using Plots
b0 = 2
a0 = 1
N = 10
h = 0.1
α = 1
β = 2
p(x) = - 2/x
q(x)  = 2/x^2
r(x) = sin(log(x))/x^2


function second_derivative(f, x, h)
    return (f(x + h) - 2*f(x) + f(x - h)) / h^2
end

function first_derivative(f, x, h)
    return (f(x + h) - f(x - h)) / (2 * h)
end


function boundary_value()
    l = zeros(N)
    u = zeros(N)
    a = zeros(N)
    b = zeros(N)
    c = zeros(N)    
    d = zeros(N)
    w = zeros(N+1)
    z = zeros(N)
    x = 0


  x = a0 + h

  a[2] = 2 + h^2 * q(x)
  b[2] = -1 + h/2 * p(x)
  d[2] = -h^2 * r(x) + (1 + h/2 * p(x)) * α

  for i in 3:N-1
    x = a0 + i*h
    a[i] = 2 + h^2 * q(x)
    b[i] = -1 + h/2 * p(x)
    c[i] = -1 - h/2 * p(x)
    d[i] = -h^2 * r(x)
  end

  x = b0 - h
    a[N] = 2 + h^2 * q(x)
    c[N] = -1 - h/2 * p(x)
    d[N] = -h^2 * r(x) + (1 - h/2 * p(x)) * β


    l[2] = a[2]
    u[2] = b[2] / a[2]
    z[2] = d[2] / l[2]

    for i in 3:N-1
        l[i] = a[i] - c[i] * u[i-1]
        u[i] = b[i] / l[i]
        z[i] = (d[i] - c[i] * z[i-1]) / l[i]
    end

    l[N] = a[N] - c[N] * u[N-1]
    z[N] = (d[N] - c[N] * z[N-1]) / l[N]

    w[1] = α
    w[N+1] = β
    w[N] = z[N]

    for i in N-1:-1:2
        w[i] = z[i] - u[i] * w[i+1]
    end


    x = a0
    for i in 1:N+1
       
        println("x = ", x, " w = ", w[i])
        x = a0 + i*h
    end
    


end

boundary_value()
