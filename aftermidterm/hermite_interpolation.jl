
x_vals = [1.3,1.6,1.9]
y_vals = [0.6200860,0.4554022,0.2818186]
derivative_vals = [-0.5220232,-0.5698959,-0.5811571]

function hermite_interpolation(x_vals, y_vals, derivative_vals)
    n = length(x_vals)
    z = zeros(2*n+1)
    Q = zeros(2*n+1, 2*n+1) 


    for i in 1:n
        z[2*i-1] = x_vals[i]
        z[2*i] = x_vals[i]
        Q[2*i-1, 1] = y_vals[i]
        Q[2*i, 1] = y_vals[i]
        Q[2*i, 2] = derivative_vals[i]

        if i != 1
            Q[2*i-1, 2] = (Q[2*i-1, 1] - Q[2*i-2, 1]) / (z[2*i-1] - z[2*i-2])
        end

    end

    for i in 3:2*n+1
        for j in 3:i
            Q[i, j] = (Q[i, j-1] - Q[i-1, j-1]) / (z[i] - z[i-j+1])

        end
    end
    return Q,z
end

Q,z =  hermite_interpolation(x_vals, y_vals, derivative_vals) 
n = length(x_vals)
for i in 1:2*n
    println(Q[i, :])
end

function construct_hermite_polynomial(Q, z)
    n = (size(Q, 1) - 1) ÷ 2  # Number of interpolation points
    x_vals = z[1:2:end]  # Extract x values from z

    # Initialize the polynomial expression
    polynomial = ""

    # Construct the polynomial expression using divided differences
    for i in 1:2*n
        if i != 1
            polynomial *= " + "
        end
        polynomial *= string(Q[i, i])
        for j in 1:i-1
            polynomial *= "(x - $(z[j]))"
        end
    end



    return polynomial
end
function calculate_hermite_polynomial(x,Q, z)
    n = (size(Q, 1) - 1) ÷ 2  # Number of interpolation points
    x_vals = z[1:2:end]  # Extract x values from z

    # Initialize the polynomial expression
    polynomial_big = 0
    polynomial = 0

    # Construct the polynomial expression using divided differences
    for i in 1:2*n
        
        polynomial = Q[i, i]
        for j in 1:i-1
            polynomial *= (x - (z[j]))
        end
        polynomial_big += polynomial
    end



    return polynomial_big
end

println(construct_hermite_polynomial(Q, z))

println(calculate_hermite_polynomial(1.5,Q, z))





