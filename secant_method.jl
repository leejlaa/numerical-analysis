# Define the function
f(x) = x^5 +x^3+3

# Define the initial guesses
x0 = -1.0
x1 = 1.0

# Define tolerance and maximum iterations
tol = 1e-6
max_iter = 100
println("n is: 0 ")
print("f(x0)")
println(f(x0))
print("f(x1)")
println(f(x1))



# Apply the secant method
function secant_method(f, x0, x1, tol, max_iter)
    iter = 0
    while abs(f(x1)) > tol && iter < max_iter
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
        x0 = x1
        x1 = x2
        iter += 1
        print("x0 ")
        println(x0)
        print("f(x0)")
        println(f(x0))
        print("x1 ")
        println(x1)
        print("f(x1)")
        println(f(x1))
    end
   
    return x1
end

# Call the secant method
result = secant_method(f, x0, x1, tol, max_iter)

# Print out the result
println("Root found by secant method: ", result)
