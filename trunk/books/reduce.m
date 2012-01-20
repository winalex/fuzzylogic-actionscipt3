function Reduce
%#codegen
% function Reduce
% This function takes a two-input, one-output fuzzy system
% with an arbitrary number of membership functions for the
% two inputs and the one output.  This function reduces the
% system so that each input has 2 or 3 membership functions.
% It is assumed that the initial membership functions are
% symmetric triangles.  It is further assumed that the function
% FuzzFunc.m is in a directory which is part of MATLAB's path.

% Copyright 1999 Dan Simon.
% No rights reserved.  You can copy this file, change it, delete it,
% sell it, use it in a commercial product, make lots of money with it,
% whatever, I don't care.
% The algorithm implemented in this file is based on "Reduction of Fuzzy
% Rule Base Via Singular Value Decomposition," by Yeung Yam, Peter Baranyi,
% and Chi-Tin Yang, in IEEE Transactions on Fuzzy Systems, pp. 120-132,
% April 1999.

close all;
sColor = ['r--'; 'g: '; 'b- '];
eps = 0.00001;

disp('Enter the centroids of the fuzzy membership functions');
disp('for input #1 in vector form.  The number of centroids must be odd.');
disp('(Note that you can just hit Enter to use the demo values for input #1.)');
disp('A valid entry might look something like this:');
disp('[-3 -2 -1 0 1 2 3]');
c1 = input('');
if (size(c1,1) == 0) & (size(c1,2) == 0)
  c1 = [-2 -1 0 1 2];
  disp('The centroids for input #1 are as follows:');
  disp(c1);
  input('Hit Enter to continue.');
  disp(' ');
end
n1 = size(c1,2);
if rem(n1, 2) == 0
  disp('The number of centroids must be odd.  Program aborted.');
  return;
elseif n1 < 5
  disp('The number of centroids must be at least 5.  Program aborted.');
  return;
elseif size(c1,1) > 1
  disp('The centroids must be entered in row-vector form.  Program aborted.');
  return;
else
  for i = 2: n1
    if c1(i) <= c1(i-1)
      disp('The centroids must be entered in ascending order.  Program aborted.');
      return;
    end
  end
end

for i = 2: n1
  b1minus(i) = c1(i) - c1(i-1);
end
b1minus(1) = b1minus(2);

for i = 1: n1 - 1
  b1plus(i) = c1(i+1) - c1(i);
end
b1plus(n1) = b1plus(n1-1);

disp('Enter the centroids of the fuzzy membership functions');
disp('for input #2 in vector form.  The number of centroids must be odd.');
disp('(Note that you can just hit Enter to use the demo values for input #2.)');
c2 = input('');
if (size(c2,1) == 0) & (size(c2,2) == 0)
  c2 = [-4 -3 -2 -1 0 1 2 3 4];
  disp('The centroids for input #2 are as follows:');
  disp(c2);
  input('Hit Enter to continue.');
  disp(' ');
end
n2 = size(c2,2);
if rem(n2, 2) == 0
  disp('The number of centroids must be odd.  Program aborted.');
  return;
elseif n2 < 5
  disp('The number of centroids must be at least 5.  Program aborted.');
  return;
elseif size(c2,1) > 1
  disp('The centroids must be entered in row-vector form.  Program aborted.');
  return;
else
  for i = 2: n2
    if c2(i) <= c2(i-1)
      disp('The centroids must be entered in ascending order.  Program aborted.');
      return;
    end
  end
end

for i = 2: n2
  b2minus(i) = c2(i) - c2(i-1);
end
b2minus(1) = b2minus(2);

for i = 1: n2 - 1
  b2plus(i) = c2(i+1) - c2(i);
end
b2plus(n2) = b2plus(n2-1);

disp('Enter the rule base in matrix form, where the rows represent');
disp('values of the first input, the columns represent values');
disp('of the second input, and the matrix elements represent the centroids');
disp('of the output membership functions.');
disp('(Note that you can just hit Enter to use the demo rule base.)');
disp('A valid rule base matrix might look something like this:');
disp('[4  3  2  1  0;');
disp(' 3  2  1  0 -1;');
disp(' 2  1  0 -1 -2;');
disp(' 1  0 -1 -2 -3;');
disp(' 0 -1 -2 -3 -4]');
F = input('');

if (size(F,1) == 0) & (size(F,2) == 0)
  F = [6  5  4  3  2  1  0 -1 -2;
       5  4  3  2  1  0 -1 -2 -3;
       4  3  2  1  0 -1 -2 -3 -4;
       3  2  1  0 -1 -2 -3 -4 -5;
       2  1  0 -1 -2 -3 -4 -5 -6];
  disp('The rule base matrix is as follows:');
  disp(F);
  input('Hit Enter to continue.');
  disp(' ');
end

if size(F,1) ~= n1
  disp('The number of rows in the rule base matrix must be equal to');
  disp('the number of fuzzy sets for input #1.  Program aborted.');
  return;
elseif size(F,2) ~= n2
  disp('The number of columns in the rule base matrix must be equal to');
  disp('the number of fuzzy sets for input #2.  Program aborted.');
  return;
end

[U, Sigma, V] = svd(F);

disp('The singular values of your rule base matrix are as follows:');
disp(diag(Sigma)');
disp('We will keep the two largest singular values to reduce the rule base.');
input('Hit Enter to continue.');
disp(' ');

Ur = U(:, 1:2);
UrT = Ur';
Sigmar = Sigma(1:2, 1:2);
Vr = V(:, 1:2);
VrT = Vr';

Ud = U(:, 3:n1);
UdT = Ud';

Vd = V(:, 3:n2);
VdT = Vd';

% Check if sum(Ur') contains any zeros, then compute the appropriate Phia matrix.
ContainsZeros = 0;
RowSum = [];
for Row = 1: size(UrT, 1)
  RowSum(Row) = 0;
  for Col = 1: size(UrT, 2)
    RowSum(Row) = RowSum(Row) + UrT(Row, Col);
  end
  if abs(RowSum(Row)) < eps
    ContainsZeros = 1;
  else
    ntilde = Row;
  end
end
if ContainsZeros == 1
  Phia = eye(2) + [zeros(2, ntilde - 1) RowSum' - ones(2, 1) zeros(2, 2 - ntilde)];
else
  Phia = diag(RowSum);
end

% Compute the Sa2 matrix.
for Row = 1: size(UdT, 1)
  SumUdT(Row, 1) = 0;
  for Col = 1: size(UdT, 2)
    SumUdT(Row, 1) = SumUdT(Row, 1) + UdT(Row, Col);
  end
end
if norm(SumUdT, 1) < eps
  Sa2 = Ur * Phia;
else
  Phia = [Phia zeros(2, 1); zeros(1, 2) 1];
  Sa2 = [Ur Ud * SumUdT] * Phia;
end

% Verify that Sa2 is sum normal.
for Row = 1 : size(Sa2, 1)
  RowSum = 0;
  for Col = 1 : size(Sa2, 2)
    RowSum = RowSum + Sa2(Row, Col);
  end
  if abs(RowSum - 1) > eps
    disp(['Sa2 is not sum normal.  RowSum = ', num2str(RowSum), '.  Program aborted.']);
    return;
  end
end

% Check if sum(Vr') contains any zeros, the compute the appropriate Phib matrix.
ContainsZeros = 0;
RowSum = [];
for Row = 1 : size(VrT, 1)
  RowSum(Row) = 0;
  for Col = 1 : size(VrT, 2)
    RowSum(Row) = RowSum(Row) + VrT(Row, Col);
  end
  if abs(RowSum(Row)) < eps
    ContainsZeros = 1;
  else
    ntilde = Row;
  end
end
if ContainsZeros == 1
  Phib = eye(2) + [zeros(2, ntilde - 1) RowSum' - ones(2, 1) zeros(2, 2 - ntilde)];
else
  Phib = diag(RowSum);
end

% Compute the Sb2 matrix.
for Row = 1 : size(VdT, 1)
  SumVdT(Row, 1) = 0;
  for Col = 1 : size(VdT, 2)
    SumVdT(Row, 1) = SumVdT(Row, 1) + VdT(Row, Col);
  end
end
if norm(SumVdT, 1) < eps
  Sb2 = Vr * Phib;
else
  Phib = [Phib zeros(2, 1); zeros(1, 2) 1];
  Sb2 = [Vr Vd * SumVdT] * Phib;
end

% Verify that Sb2 is sum normal.
for Row = 1 : size(Sb2, 1)
  RowSum = 0;
  for Col = 1 : size(Sb2, 2)
    RowSum = RowSum + Sb2(Row, Col);
  end
  if abs(RowSum - 1) > eps
    disp(['Sb2 is not sum normal.  RowSum = ', num2str(RowSum), '.  Program aborted.']);
    return;
  end
end

% Compute the NSa2 matrix.
ZetaMin = 1000000;
for Row = 1 : size(Sa2, 1)
  for Col = 1 : size(Sa2, 2)
    ZetaMin = min(ZetaMin, Sa2(Row, Col));
  end
end
if ZetaMin >= -1
  ZetaMin = 1;
else
  ZetaMin = 1 / abs(ZetaMin);
end
NSa2 = ones(size(Sa2, 2), size(Sa2, 2));
for Row = 1 : size(NSa2, 1)
  NSa2(Row, Row) = 1 + ZetaMin;
end
NSa2 = NSa2 / (size(NSa2, 1) + ZetaMin);
% Verify that NSa2 is sum normal.
for Row = 1 : size(NSa2, 1)
  RowSum = 0;
  for Col = 1 : size(NSa2, 2)
    RowSum = RowSum + NSa2(Row, Col);
  end
  if abs(RowSum - 1) > eps
    disp(['NSa2 is not sum normal.  RowSum = ', num2str(RowSum), '.  Program aborted.']);
    return;
  end
end

% Compute the NSb2 matrix.
ZetaMin = 1000000;
for Row = 1 : size(Sb2, 1)
  for Col = 1 : size(Sb2, 2)
    ZetaMin = min(ZetaMin, Sb2(Row, Col));
  end
end
if ZetaMin >= -1
  ZetaMin = 1;
else
  ZetaMin = 1 / abs(ZetaMin);
end
NSb2 = ones(size(Sb2, 2), size(Sb2, 2));
for Row = 1 : size(NSb2, 1)
  NSb2(Row, Row) = 1 + ZetaMin;
end
NSb2 = NSb2 / (size(NSb2, 1) + ZetaMin);
% Verify that NSb2 is sum normal.
for Row = 1 : size(NSb2, 1)
  RowSum = 0;
  for Col = 1 : size(NSb2, 2)
    RowSum = RowSum + NSb2(Row, Col);
  end
  if abs(RowSum - 1) > eps
    disp(['NSb2 is not sum normal.  RowSum = ', num2str(RowSum), '.  Program aborted.']);
    return;
  end
end

% Augment the Sigmar matrix if needed.
if size(Phia, 1) > size(Sigmar, 1)
  Sigmar(size(Phia, 1), 1) = 0;
end
if size(Phib, 1) > size(Sigmar, 2)
  Sigmar(1, size(Phib, 1)) = 0;
end

Utilde = Sa2 * NSa2;
Rtilde = inv(NSa2) * inv(Phia) * Sigmar * inv(Phib') * inv(NSb2');
Vtilde = Sb2 * NSb2;

% Compute the Qa matrix.
if size(Utilde, 2) == 3
  Qa = inv([Utilde(1,:); Utilde((1+n1)/2,:); Utilde(n1,:)]);
elseif size(Utilde, 2) == 2
  UtildeMin = min(Utilde);
  UtildeMax = max(Utilde);
  for Row = 1: size(Utilde, 1)
    for Col = 1: 2
      if Utilde(Row, Col) == UtildeMin(Col)
        MinRow(Col) = Row;
      elseif Utilde(Row, Col) == UtildeMax(Col)
        MaxRow(Col) = Row;
      end
    end
  end
  if ~(((MinRow(1) == MinRow(2)) & (MaxRow(1) == MaxRow(2))) | ...
       ((MinRow(1) == MaxRow(2)) & (MaxRow(1) == MinRow(2))))
    disp('Error computing convex hull of Utilde.  Program aborted.');
    return;
  end
  if MinRow(1) ~= MinRow(2)
    Qa = inv([Utilde(MinRow(1),:); Utilde(MinRow(2),:)]);
  else
    Qa = inv([Utilde(MinRow(1),:); Utilde(MaxRow(1),:)]);
  end
else
  disp(['Unexpected size for Utilde - size(Utilde, 2) = ', num2str(size(Utilde, 2)), '.  Program aborted.']);
  return;
end
Ubar = Utilde * Qa;

% Plot the original membership functions for input #1.
figure;
hold on;
x1 = c1(1) - b1minus(1): ((c1(n1) + b1plus(n1)) - (c1(1) - b1minus(1))) / 200: c1(n1) + b1plus(n1);
A(1,:) = FuzzFunc(c1(1)-b1minus(1), 1, c1(1), 1, c1(1)+b1plus(1), 0, x1);
plot(x1, A(1,:));
for i = 2: n1-1
  A(i,:) = FuzzFunc(c1(i)-b1minus(i), 0, c1(i), 1, c1(i)+b1plus(i), 0, x1);
  plot(x1, A(i,:));
end
A(n1,:) = FuzzFunc(c1(n1)-b1minus(n1), 0, c1(n1), 1, c1(n1)+b1plus(n1), 1, x1);
plot(x1, A(n1,:));
axis([c1(1) - b1minus(1) c1(n1) + b1plus(n1) 0 1]);
title('Original Memberships for Input #1');
hold off;

% Compute the new membership functions for input #1 for the reduced rule base.
Abar = zeros(size(Utilde, 2), size(A, 2));
for ibar = 1 : size(Utilde, 2)
  for i = 1 : size(Utilde, 1)
    for a = 1 : size(Abar, 2)
      Abar(ibar, a) = Abar(ibar, a) + A(i, a) * Ubar(i, ibar);
    end
  end
end

% Plot the new membership functions for input #1 for the reduced rule base.
figure;
hold on;
for ibar = 1 : size(Abar, 1)
  plot(x1, Abar(ibar,:), sColor(ibar,:));
end
defaultaxis = axis;
axis([c1(1) - b1minus(1) c1(n1) + b1plus(n1) defaultaxis(3) defaultaxis(4)]);
title('Reduced Memberships for Input #1');
hold off;

% Compute the Qb matrix.
if size(Vtilde, 2) == 3
  Qb = inv([Vtilde(1,:); Vtilde((1+n2)/2,:); Vtilde(n2,:)]);
elseif size(Vtilde, 2) == 2
  VtildeMin = min(Vtilde);
  VtildeMax = max(Vtilde);
  for Row = 1: size(Vtilde, 1)
    for Col = 1: 2
      if Vtilde(Row, Col) == VtildeMin(Col)
        MinRow(Col) = Row;
      elseif Vtilde(Row, Col) == VtildeMax(Col)
        MaxRow(Col) = Row;
      end
    end
  end
  if ~(((MinRow(1) == MinRow(2)) & (MaxRow(1) == MaxRow(2))) | ...
       ((MinRow(1) == MaxRow(2)) & (MaxRow(1) == MinRow(2))))
    disp('Error computing convex hull of Vtilde.  Program aborted.');
    return;
  end
  if MinRow(1) ~= MinRow(2)
    Qb = inv([Vtilde(MinRow(1),:); Vtilde(MinRow(2),:)]);
  else
    Qb = inv([Vtilde(MinRow(1),:); Vtilde(MaxRow(1),:)]);
  end
else
  disp(['Unexpected size for Vtilde - size(Vtilde, 2) = ', num2str(size(Vtilde, 2)), '.  Program aborted.']);
  return;
end
Vbar = Vtilde * Qb;

% Plot the original membership functions for input #2.
figure;
hold on;
x2 = c2(1) - b2minus(1): ((c2(n2) + b2plus(n2)) - (c2(1) - b2minus(1))) / 200: c2(n2) + b2plus(n2);
B(1,:) = FuzzFunc(c2(1)-b2minus(1), 1, c2(1), 1, c2(1)+b2plus(1), 0, x2);
plot(x2, B(1,:));
for i = 2: n2-1
  B(i,:) = FuzzFunc(c2(i)-b2minus(i), 0, c2(i), 1, c2(i)+b2plus(i), 0, x2);
  plot(x2, B(i,:));
end
B(n2,:) = FuzzFunc(c2(n2)-b2minus(n2), 0, c2(n2), 1, c2(n2)+b2plus(n2), 1, x2);
plot(x2, B(n2,:));
axis([c2(1) - b2minus(1) c2(n2) + b2plus(n2) 0 1]);
title('Original Memberships for Input #2');
hold off;

% Compute the new membership functions for input #2 for the reduced rule base.
Bbar = zeros(size(Vtilde, 2), size(B, 2));
for jbar = 1 : size(Vtilde, 2)
  for j = 1 : size(Vtilde, 1)
    for b = 1 : size(Bbar, 2)
      Bbar(jbar, b) = Bbar(jbar, b) + B(j, b) * Vbar(j, jbar);
    end
  end
end

% Plot the new membership functions for input #2 for the reduced rule base.
figure;
hold on;
for jbar = 1 : size(Bbar, 1)
  plot(x2, Bbar(jbar,:), sColor(jbar,:));
end
defaultaxis = axis;
axis([c2(1) - b2minus(1) c2(n2) + b2plus(n2) defaultaxis(3) defaultaxis(4)]);
title('Reduced Memberships for Input #2');
hold off;

Rbar = inv(Qa) * Rtilde * inv(Qb');

% Get all of the unique Rbar entries into the cout array.
% The cout array defines the centroids of the new membership functions
% for the output for the reduced rule base.
cout = [];
for i = 1: size(Rbar, 1)
  for j = 1: size(Rbar, 2)
    iFound = 0;
    for k = 1: size(cout, 2)
      if abs(Rbar(i, j) - cout(k)) < eps
        iFound = 1;
        break;
      end
    end
    if iFound == 0
      cout = [cout Rbar(i, j)];
    end
  end
end
cout = sort(cout);
nout = size(cout, 2);

% Compute the half-widths of the new membership functions for the output
% for the reduced rule base.  Go with the assumption that the sum of
% all the membership functions for any value of the output is one.
for i = 2: nout
  boutminus(i) = cout(i) - cout(i-1);
end
boutminus(1) = boutminus(2);

for i = 1: nout - 1
  boutplus(i) = cout(i+1) - cout(i);
end
boutplus(nout) = boutplus(nout-1);

% Plot the new membership functions for the output for the reduced rule base.
xout = cout(1) - boutminus(1): ((cout(nout) + boutplus(nout)) - (cout(1) - boutminus(1))) / 200: cout(nout) + boutplus(nout);
figure;
hold on;
R(1,:) = FuzzFunc(cout(1) - boutminus(1), 1, cout(1), 1, cout(1) + boutplus(1), 0, xout);
plot(xout, R(1,:));
for i = 2 : nout-1
  R(i,:) = FuzzFunc(cout(i) - boutminus(i), 0, cout(i), 1, cout(i) + boutplus(i), 0, xout);
  plot(xout, R(i,:));
end
R(nout,:) = FuzzFunc(cout(nout) - boutminus(nout), 0, cout(nout), 1, cout(nout) + boutplus(nout), 1, xout);
plot(xout, R(nout,:));
axis([cout(1) - boutminus(1) cout(nout) + boutplus(nout) 0 1]);
title('Reduced Memberships for Output');
hold off;

% Write CSV files containing the reduced membership functions.
% The CSV files may need to be edited and saved with an
% editor in order to convert the linefeeds to carriage return / linefeed pairs.
disp('Please wait while the CSV files are being written...');
csvwrite('Abar.csv', [x1' Abar']);
csvwrite('Bbar.csv', [x2' Bbar']);
csvwrite('Rbar.csv', [xout' R']);

disp(' ');
disp('The reduced membership functions have been written to the files');
disp('Abar.csv, Bbar.csv, and Rbar.csv in your default MATLAB directory.');
disp('The first column in the files contains the independent variable,');
disp('the second column contains the values of the first membership function,');
disp('the third column contains the values of the second membership function, etc.');
disp('(Note that any element whose value is 0 is omitted in the CSV file.)');
disp('The program has completed successfully.');
disp(' ');

