A = [1.0 1.0 2.0
     0.0 2.0 -7.0
     3.0 6.0 -5.0]

b = [9.0
    -17.0
     0.0]

     println("The system of equations is:")
    println(A\b)

function upper_triangular(R, b)
    n = length(b)
    x = copy(b)
    x[n] = b[n] / R[n, n]

    for i = n-1:-1:1
        x[i] = b[i]
        for j = i+1:n
            x[i] = x[i] - R[i, j] * x[j]
        end
        x[i] = x[i] / R[i, i]
    end
    return x
end

function lower_triangular(L, b)
    n = length(b)
    x = copy(b)
    x[1] = b[1] / L[1, 1]

    for i = 2:n
        x[i] = b[i]
        for j = 1:i-1
            x[i] = x[i] - L[i, j] * x[j]
        end
        x[i] = x[i] / L[i, i]
    end

    return x
end

function extract(A)
    n = size(A, 1)
    L = zeros(n, n)
    U = zeros(n, n)
    for i = 1:n
        for j = 1:n
            if i == j
                L[i, j] = 1
                U[i, j] = A[i, j]
            elseif i > j
                L[i, j] = A[i, j]
            else
                U[i, j] = A[i, j]
            end
        end
    end
    return L, U
end

function gaussian(A, b)
    n = length(b)
    p = collect(1:n)
    for k = 1:n-1
        max = argmax(abs.(A[k:end, k])) + k - 1
        A[k, k:n], A[max, k:n] = A[max, k:n], A[k, k:n]
        p[[k, max]] = p[[max, k]]
        d = 1 / A[k, k]
        for i = k+1:n
            A[i, k] = A[i, k] * d
            # b[i] = b[i] - A[i, k] * b[k]
            for j = k+1:n
                A[i, j] = A[i, j] - A[i, k] * A[k, j]
            end
        end
    end
    return A, p, b
end

A, p, b = gaussian(A, b)
L, U = extract(A)
b = b[p]
y = lower_triangular(L, b)
x = upper_triangular(U, y)

println("The solution is x = $x")

