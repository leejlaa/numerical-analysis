function bisection_method(f, a, b, tol=1e-10, max_iter=100)
    # Check if the interval is valid
    if f(a) * f(b) > 0
        error("Invalid interval: f(a) and f(b) must have different signs.")
    end
    
    # Initialize variables
    c = (a + b) / 2
    iter = 0
    n=0
    print("n is ")
    println(n)
    print("c is: " )
    println(c)
    print("f(cn) is ")
    println(f(c))
    
    
    # Iterative bisection loop
    while (b - a) / 2^tol > tol && iter < max_iter
        if f(c) == 0
            println("Exact solution found: ", c)
            break
        else
            if f(a) * f(c) < 0
                b = c
            else
                a = c
            end
            n=n+1
            c = a+ (b - a) / 2 
            print("n is ")
            println(n)
            print("c is: " )
            println(c)
            print("f(cn) is ")
            println(f(c))
            iter += 1
        end
        
    end
    
    # Check if convergence achieved
    if iter == max_iter
        println("Warning: Maximum number of iterations reached.")
    end
    
    return c
end

result = bisection_method(x -> x^3 - 2*sin(x), 0.5, 2.0, 1e-10, 100)
println("Approximate solution: ", result)


