function k_value = k_test ( x_num, x, t )

%*****************************************************************************80
%
%% K_TEST01 evaluates the K coefficient for problem 1.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    29 January 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer X_NUM, the number of evaluation points.
%
%    Input, real X(X_NUM,1), the evaluation points.
%
%    Input, real T, the evaluation time.
%
%    Output, real K_VALUE(X_NUM,1), the value of K(X,T).
%
%   k_value(1:x_num,1) = 0.002;
    dx = x(2)-x(1);
    k_value(1:x_num,1) = dx.^2/pi.^2;
  return
end