#!/usr/bin/env julia
#=
Link first use of glossary terms to their glossary definitions.

Scans all website .qmd files (excluding manuscript/ and the glossary
itself) and wraps the first occurrence of each glossary term in a
link to its glossary entry.

Usage:
    julia scripts/link-glossary.jl          # apply links
    julia scripts/link-glossary.jl --check  # exit 1 if changes needed
=#

const GLOSSARY_PATH = joinpath("resources", "glossary.qmd")
const EXCLUDE_DIRS = ["manuscript", joinpath("meeting", "templates"),
                      "_site", ".quarto"]

function parse_glossary(path::String)::Vector{Tuple{String,String}}
    content = read(path, String)
    terms = Tuple{String,String}[]
    for m in eachmatch(r"^###\s+(.+?)\s*\{#([^}]+)\}"m, content)
        push!(terms, (m.captures[1], m.captures[2]))
    end
    return terms
end

function is_excluded(path::String)::Bool
    path == GLOSSARY_PATH && return true
    for excl in EXCLUDE_DIRS
        startswith(path, excl * "/") && return true
        path == excl && return true
    end
    return false
end

function find_qmd_files(root::String)::Vector{String}
    files = String[]
    for (dir, _, filenames) in walkdir(root)
        for f in filenames
            endswith(f, ".qmd") || continue
            full = joinpath(dir, f)
            rel = relpath(full, root)
            is_excluded(rel) && continue
            push!(files, rel)
        end
    end
    return sort(files)
end

function in_front_matter(content::String, pos::Int)::Bool
    startswith(content, "---") || return false
    close = findnext("---", content, 4)
    isnothing(close) && return false
    return pos < last(close) + 1
end

function in_code(content::String, pos::Int)::Bool
    for m in eachmatch(r"```.*?```"s, content)
        m.offset <= pos < m.offset + length(m.match) && return true
    end
    for m in eachmatch(r"`[^`]+`", content)
        m.offset <= pos < m.offset + length(m.match) && return true
    end
    return false
end

function in_comment(content::String, pos::Int)::Bool
    for m in eachmatch(r"<!--.*?-->"s, content)
        m.offset <= pos < m.offset + length(m.match) && return true
    end
    return false
end

function in_heading(content::String, pos::Int)::Bool
    line_start = findprev('\n', content, pos)
    line_start = isnothing(line_start) ? 1 : line_start + 1
    line_end = findnext('\n', content, pos)
    line_end = isnothing(line_end) ? lastindex(content) : line_end
    line = content[line_start:line_end]
    return startswith(lstrip(line), "#")
end

function in_title(content::String, pos::Int)::Bool
    line_start = findprev('\n', content, pos)
    line_start = isnothing(line_start) ? 1 : line_start + 1
    line_end = findnext('\n', content, pos)
    line_end = isnothing(line_end) ? lastindex(content) : line_end
    line = content[line_start:line_end]
    return startswith(lstrip(line), "title:")
end

function in_existing_link(content::String, start::Int, stop::Int)::Bool
    before = content[1:prevind(content, start)]
    open_bracket = findlast('[', before)
    if !isnothing(open_bracket)
        close_bracket = findnext(']', content, open_bracket)
        if !isnothing(close_bracket) && close_bracket >= stop
            return true
        end
    end
    paren_pos = findlast("](", before)
    if !isnothing(paren_pos)
        close_paren = findnext(')', content, first(paren_pos))
        if !isnothing(close_paren) && close_paren >= stop
            return true
        end
    end
    return false
end

function in_bold(content::String, start::Int, stop::Int)::Bool
    before = content[1:prevind(content, start)]
    bold_before = findlast("**", before)
    isnothing(bold_before) && return false
    after = content[stop:end]
    bold_after = findfirst("**", after)
    isnothing(bold_after) && return false
    between = content[last(bold_before)+1:prevind(content, start)]
    occursin("**", between) && return false
    return true
end

function in_table(content::String, pos::Int)::Bool
    line_start = findprev('\n', content, pos)
    line_start = isnothing(line_start) ? 1 : line_start + 1
    line_end = findnext('\n', content, pos)
    line_end = isnothing(line_end) ? lastindex(content) : line_end
    line = content[line_start:line_end]
    return startswith(lstrip(line), "|")
end

function glossary_rel_path(file_path::String)::String
    dir = dirname(file_path)
    parts = isempty(dir) ? String[] : split(dir, "/")
    prefix = join(fill("..", length(parts)), "/")
    isempty(prefix) && return GLOSSARY_PATH
    return prefix * "/" * GLOSSARY_PATH
end

function link_terms(content::String,
                    terms::Vector{Tuple{String,String}},
                    glossary_rel::String)::String
    for (term, anchor) in terms
        pattern = Regex("\\b" * replace(term, r"[-]" => "[-]") *
                        "s?\\b", "i")
        for m in eachmatch(pattern, content)
            start = m.offset
            stop = start + length(m.match)
            in_front_matter(content, start) && continue
            in_code(content, start) && continue
            in_comment(content, start) && continue
            in_heading(content, start) && continue
            in_title(content, start) && continue
            in_existing_link(content, start, stop) && continue
            in_bold(content, start, stop) && continue
            in_table(content, start) && continue
            matched = m.match
            link = "[$(matched)]($(glossary_rel)#$(anchor))"
            content = content[1:prevind(content, start)] *
                      link *
                      content[stop:end]
            break
        end
    end
    return content
end

function main()
    check_mode = "--check" in ARGS

    if !isfile(GLOSSARY_PATH)
        println("Glossary not found at $GLOSSARY_PATH")
        exit(1)
    end

    terms = parse_glossary(GLOSSARY_PATH)
    if isempty(terms)
        println("No glossary terms found")
        return
    end

    term_names = join([t[1] for t in terms], ", ")
    println("Found $(length(terms)) glossary terms: $term_names")

    files = find_qmd_files(".")
    changed_files = String[]

    for f in files
        content = read(f, String)
        rel = glossary_rel_path(f)
        new_content = link_terms(content, terms, rel)
        if new_content != content
            push!(changed_files, f)
            if !check_mode
                write(f, new_content)
                println("  Updated: $f")
            end
        end
    end

    if check_mode
        if !isempty(changed_files)
            println("\n$(length(changed_files)) file(s) need glossary links:")
            for f in changed_files
                println("  $f")
            end
            exit(1)
        else
            println("All glossary links are up to date.")
        end
    else
        if !isempty(changed_files)
            println("\nUpdated $(length(changed_files)) file(s).")
        else
            println("No changes needed.")
        end
    end
end

main()
