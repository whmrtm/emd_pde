

% Set the nodes
x_num = 21;
x_min = 0.0;
x_max = 1.0;
dx = ( x_max - x_min ) / ( x_num - 1 );
x = ( linspace ( x_min, x_max, x_num ) )';

% Set the times

t_num = 401;
t_min = 0.0;
t_max = 30.0;
dt = (t_max-t_min)/(t_num-1);
t = ( linspace(t_min, t_max, t_num ))';


% Finite Element info

element_num = x_num - 1;
element_node(1,1:element_num) = 1:x_num-1;
element_node(2,1:element_num) = 2:x_num;
quad_num = 3;

mass = assemble_mass(x_num, x, element_num, element_node, quad_num);


u_mat = zeros(x_num, t_num);
for j = 1:t_num
    if(j==1)
        u(1:x_num,1) = ic(x_num, x, t(j));
        u(1:x_num,1) = bc(x_num, x, t(j), u(1:x_num,1));
    else
        u(1:x_num,1) = fem1d_heat_explicit ( x_num, x, t(j-1), dt, @k_test, ...
        @rhs, @bc, element_num, element_node, quad_num, mass, u );

    end

    u_mat(1:x_num,j) = u(1:x_num,1);

end

%
%  Make a product grid of T and X for plotting.
%

[ t_mat, x_mat ] = meshgrid ( t, x );

%
%  Make a mesh plot of the solution.
%

mesh ( t_mat, x_mat, u_mat )
xlabel ( '<--Time-->' )
ylabel ( '<--X-->' )
zlabel ( '<--H(X,T)-->' )
title ( 'H(X,T) for TEST01, by FEM1D\_HEAT\_EXPLICIT' )
%
%  Write the data to files.
%
%   r8mat_write ( 'h_test01.txt', x_num, t_num, u_mat );
%   r8vec_write ( 't_test01.txt', t_num, t );
%   r8vec_write ( 'x_test01.txt', x_num, x );

%   fprintf ( 1, '\n' );
%   fprintf ( 1, '  H(X,T) written to "h_test01.txt"\n' );
%   fprintf ( 1, '  T values written to "t_test01.txt"\n' );
%   fprintf ( 1, '  X values written to "x_test01.txt"\n' );

