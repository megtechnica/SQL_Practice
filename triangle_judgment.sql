-- from the side lengths, would these lines form a triangle?

select *, if(x+y>z and x+z>y and y+z>x, "Yes", "No") as triangle from triangle
