using LinearAlgebra
using Plots

a, b = 1.0, 2.0
n = 16
h = (b - a) / (n + 1) 
t = range(a, stop=b, length=n)  

y = zeros(n)
y[end] = log(2)  

function F(y)
    F = zeros(n)
    F[2:end-1] = (y[3:end] - 2*y[2:end-1] + y[1:end-2]) / h^2 +((y[3:end] - y[1:end-2]) / (2*h)).^2 + y[2:end-1] - log.(t[2:end-1])
    F[1] = y[1]
    F[end] = y[end]-log(2)
    return F
end

function approximateJacobian(y)
    n=length(y)
    J = zeros(n,n)
    delta = sqrt(eps(Float64))

    for i in 1:n
        new_x = copy(y)
        new_x[i] += delta
        J[:,i] = (F(new_x) - F(y)) / delta
    end

    return J
end


function upper_triangular(R,b)

    n= length(b)
    x = copy(b)
    x[n] = b[n]/R[n,n]

    for i = n-1:-1:1
        x[i] = b[i]
        for j = i+1:1:n
           x[i] = x[i] - R[i,j]*x[j]
        end
        x[i]= x[i]/R[i,i]
    end
    return x
end

function lower_triangular(L,b)
     
    n= length(b)
    x=copy(b)
    x[1] = b[1]/L[1,1]

    for i = 2 :1: n
        x[i] = b[i]

        for j = 1 : 1: i-1
            x[i] = x[i] - L[i,j]*x[j]
        end

        x[i] = x[i]/L[i,i]
    end

    return x

end

function extract(A)
    n=size(A,1)
    L = zeros(n, n)
    U = zeros(n, n)
    for i = 1:n
        for j = 1:n
            if i == j
                L[i,j] = 1
                U[i,j] = A[i,j]
            elseif i > j
                L[i,j] = A[i,j]
            else
                U[i,j] = A[i,j]
            end
        end
    end
    return L,U
end

function gausian(A,b)

    n = length(b)
    p = collect(1:n)
    for k = 1:n-1
        max = argmax(abs.(A[k:n,k]))+k-1
        A[k,k:n],A[max,k:n]=A[max,k:n],A[k,k:n]
        p[[k,max]] = p[[max,k]]
        d= 1/A[k,k]
        for i = k+1:n
            A[i,k] = A[i,k]*d
            b[i] = b[i] - A[i,k]*b[k]
            for j = k+1:n
                A[i,j] = A[i,j] - A[i,k]*A[k,j]
            end
        end
    end
    return A,p,b
end

function newtonsMethod(y,F,max_iterations,tolerance)
    for iteration in 1:max_iterations
       F1= F(y)
    
        if norm(F1, 2) < tolerance
            println("Converged")
            return y
        end
       
        J = approximateJacobian(y)
        A,p,b = gausian(J,F1)
        L,U = extract(A)
        b=b[p]
        Y = lower_triangular(L,b)
        d = upper_triangular(U,Y)
        y -= d
        if norm(d, 2) < tolerance
            println("Converged")
            return y
        end
    end
    println("Maximum iterations-did not converge")
    return y
end

yt = newtonsMethod(y,F,16,1e-6)

scatter(t, yt, label=" y(t)", xlabel="t", ylabel="y(t)")
plot!(t,log.(t))