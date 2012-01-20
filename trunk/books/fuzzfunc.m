function y = FuzzFunc(x1, y1, x2, y2, x3, y3, x)

% y = FuzzFunc(x1, y1, x2, y2, x3, y3, x)
% Generate the membership values of a triangular fuzzy membership 
% function.  Values are generated for each element in the x vector.
% The fuzzy function is specified with the following 3 points:  
% (x1,y1), (x2,y2), and (x3,y3), where the x's are on the horizontal
% axis, and the y's are the membership values on the vertical axis. 
% It is assumed that x1 < x2 < x3.
% In general, y1, y2, and y3 should each be 0 or 1.

% Copyright 1999 Dan Simon.
% No rights reserved.  You can copy this file, change it, delete it,
% sell it, use it in a commercial product, make lots of money with it,
% whatever, I don't care.

y = zeros(size(x));
i = 1;
while x(i) < x1
  i = i + 1;
  if i > size(x,2)
    return;
  end;
end
while x(i) < x2
  if x1 == x2
    y(i) = y(1);
  else
    y(i) = y1 + (x(i) - x1) * (y2 - y1) / (x2 - x1);
  end
  i = i + 1;
  if i > size(x,2)
    return;
  end
end
while x(i) <= x3
  if x3 == x2
    y(i) = y2;
  else
    y(i) = y2 + (x(i) - x2) * (y3 - y2) / (x3 - x2);
  end
  i = i + 1;
  if i > size(x,2)
    return;
  end
end
while i <= size(x,2)
  y(i) = 0;
  i = i + 1;
end
