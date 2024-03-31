# matrix method

A = [1.0 2 4
1.0 2.75 7.5625
1 4 16]

b= [1/2
1/2.75
1/4]

# Lagrange method
a0,a1, a2 = A\b
x=0
p(x) = a0+a1*x+a2*(x^2)
# println(p(3))



L0 = ((x- 2.75)*(x-4.0))/((2.0-2.75)*(2.0-4.0))
L1 = ((x-2)*(x-4))/((2.75-2)*(2.75-4))
L2 = ((x-2)*(x-2.75))/((4-2)*(4-2.75))

p(x) = 1/2*L0 + 1/2.75*L1 + 1/4*L2
 
# recursive method using forward substitution

a0 = 1/2
a1 = (1/2.75 - 1/2)/(2.75-2)

println(a0,a1,a2)
p(x) = a0 + a1*(x-2.75) + a2*(x-2.75)*(x-2)



