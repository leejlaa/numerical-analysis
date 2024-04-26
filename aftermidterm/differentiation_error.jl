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

function three_point_forward_difference(f, x, h)
    return (-3*f(x) + 4*f(x + h) - f(x + 2h)) / (2 * h)
end

println(three_point_forward_difference(f, x, 0.00001))

function  three_point_backward_difference(f,x,h)
    return (3*f(x) - 4*f(x - h) + f(x - 2h)) / (2 * h) 
end

println(three_point_backward_difference(f, x, 0.00001))

function second_derivative(f, x, h)
    return (f(x + h) - 2*f(x) + f(x - h)) / h^2
end

println(second_derivative(f, x, 0.00001))

