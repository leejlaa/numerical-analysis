f(x) = sin(x)
x = 1

function forward_difference(f, x, h)
    return (f(x + h) - f(x)) / h
end

println(forward_difference(f, x, 0.00001))

function  backward_difference(f, x, h)
    return (f(x) - f(x - h)) / h

end

println(backward_difference(f, x, 0.00001))

function central_difference(f, x, h)
    return (f(x + h) - f(x - h)) / (2 * h)
end

println(central_difference(f, x, 0.00001))

