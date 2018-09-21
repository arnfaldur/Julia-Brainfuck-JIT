
using Test
using JSON

const charins = ['+', '-', '<', '>', '[', ']', ',', '.' ]
const uintins = [0x2b,0x2d,0x3c,0x3e,0x5b,0x5d,0x2c,0x2e]

getfile(file) = open(f->read(f, String), file)
clean(prog) = Array{Char,1}(filter(x->(x in charins), prog))

const benchprograms = [("benchmarks//mandelbrot.bf", ""), ("benchmarks//factor.bf", "179424691")]

struct BFTest
    name::String
    program::Array{Char,1}
    input::String
    output::String
end

function getTests()
    files = readdir("tests")
    result = BFTest[]
    for i = 1:2:length(files)
        testDict = open(f->JSON.parse(f), "tests//$(files[i+1])")
        push!(result, BFTest(
            "$(files[i][1:end-3])",                 #name of test
            clean(getfile("tests//$(files[i])")),   #BF program
            testDict["feed-in"],                    #program input
            testDict["expect-out"],                 #expected output
        ))
    end
    return result
end

const testprograms = getTests()

function testBF(interpreter)
    for prog in testprograms
        println(prog.name, " -> ", @test interpreter(prog.program, prog.input) == prog.output)
    end
end

function benchmark(func)

end
