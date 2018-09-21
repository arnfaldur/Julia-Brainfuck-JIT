
const memorySize = 500

function simpleinterp(prog::Array{Char}, input::String)
    inputstream = IOBuffer(input)
    outputstream = IOBuffer()
    memory = zeros(UInt8, memorySize)
    pptr = 1
    dptr = 1

    while (pptr <= length(prog))
        ins = prog[pptr]
        if (ins == '>')
            dptr += 1
        elseif (ins == '<')
            dptr -= 1
        elseif (ins == '+')
            memory[dptr] += 0x1
        elseif (ins == '-')
            memory[dptr] -= 0x1
        elseif (ins == '.')
            print(outputstream, Char(memory[dptr]))
        elseif (ins == ',')
            memory[dptr] = read(inputstream, Char)
        elseif (ins == '[')
            if (memory[dptr] == 0)
                nesting = 1
                saved_pptr = pptr

                while (nesting > 0 && pptr+1 < length(prog))
                    pptr += 1
                    if (prog[pptr] == ']')
                        nesting -= 1
                    elseif (prog[pptr] == '[')
                        nesting += 1
                    end
                end

                if (nesting != 0)
                    error("unmatched '[' at pc=$(saved_pptr)")
                end
            end
        elseif (ins == ']')
            if (memory[dptr] != 0)
                nesting = 1
                saved_pptr = pptr

                while (nesting > 0 && pptr > 1)
                    pptr -= 1
                    if (prog[pptr] == '[')
                        nesting -= 1
                    elseif (prog[pptr] == ']')
                        nesting += 1
                    end
                end

                if (nesting != 0)
                    error("unmatched ']' at pc=$(saved_pptr)")
                end
            end
        else
            error("The instruction '$(ins)' is not welcome here")
        end
        pptr += 1
    end
    return String(take!(outputstream))
end


function interp(prog::Array{Char}, input::String)
    inputstream = IOBuffer(input)
    outputstream = IOBuffer()
    memory = zeros(UInt8, memorySize)
    pptr = 1
    dptr = 1

    while (pptr <= length(prog))
        ins = prog[pptr]
        if (ins == '>')
            dptr += 1
        elseif (ins == '<')
            dptr -= 1
        elseif (ins == '+')
            memory[dptr] += 0x1
        elseif (ins == '-')
            memory[dptr] -= 0x1
        elseif (ins == '.')
            print(outputstream, Char(memory[dptr]))
        elseif (ins == ',')
            memory[dptr] = read(inputstream, Char)
        elseif (ins == '[')
            if (memory[dptr] == 0)
                nesting = 1
                saved_pptr = pptr

                while (nesting > 0 && pptr+1 < length(prog))
                    pptr += 1
                    if (prog[pptr] == ']')
                        nesting -= 1
                    elseif (prog[pptr] == '[')
                        nesting += 1
                    end
                end

                if (nesting != 0)
                    error("unmatched '[' at pc=$(saved_pptr)")
                end
            end
        elseif (ins == ']')
            if (memory[dptr] != 0)
                nesting = 1
                saved_pptr = pptr

                while (nesting > 0 && pptr > 1)
                    pptr -= 1
                    if (prog[pptr] == '[')
                        nesting -= 1
                    elseif (prog[pptr] == ']')
                        nesting += 1
                    end
                end

                if (nesting != 0)
                    error("unmatched ']' at pc=$(saved_pptr)")
                end
            end
        else
            error("The instruction '$(ins)' is not welcome here")
        end
        pptr += 1
    end
    return String(take!(outputstream))
end
