function u = ic ( x_num, x, t )

%*****************************************************************************80
%
%% IC sets the initial condition for this pde.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    28 January 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer X_NUM, the number of nodes.
%
%    Input, real X(X_NUM,1), the node coordinates.
%
%    Input, real T, the time.
%
%    Output, real U(X_NUM,1), the initial value of U.
%
  u = zeros ( x_num, 1 );
  u(1:x_num,1) = 5*sin(2*pi*x);
  return
end