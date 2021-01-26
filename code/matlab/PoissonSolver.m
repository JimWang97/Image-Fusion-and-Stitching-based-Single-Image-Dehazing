function Targ_filled = PoissonSolver(Targ, MaskTarg, AdjacencyMat, TargBoundry)%目标图的梯度信息的原图，二值图像，连通矩阵，边界信息

%% params for Conjagant gradient solver 共轭梯度法
max_iter = 400;
tolerance = 1e-7;

[row_mask, col_mask] = find(MaskTarg);
boundary = TargBoundry{1};

Np_boundary  = zeros(size(boundary, 1), 1);
sum_boundary = zeros(size(boundary, 1), 1);
for k = 1:size(boundary, 1),
    %Calc Neighbour outside - at most 4 but unlikely - usually 1 for 4
    %connected
    [xy_pos] = boundary(k, :);
    
    Np_boundary(k) = sum(sum(~MaskTarg(xy_pos(1)-1:xy_pos(1)+1, xy_pos(2)-1:xy_pos(2)+1)&[0 1 0;1 1 1; 0 1 0]));
    mat = Targ(xy_pos(1)-1:xy_pos(1)+1, xy_pos(2)-1:xy_pos(2)+1);
    sum_boundary(k) = sum(mat(~MaskTarg(xy_pos(1)-1:xy_pos(1)+1, xy_pos(2)-1:xy_pos(2)+1)&[0 1 0;1 1 1; 0 1 0]));
    %Targ(xy_pos(1),xy_pos(2))=min(mat(~MaskTarg(xy_pos(1)-1:xy_pos(1)+1, xy_pos(2)-1:xy_pos(2)+1)&[0 1 0;1 0 1; 0 1 0]))
end
imshow(sum_boundary);
imshow(Np_boundary);
num_of_hole_pixels = size(row_mask, 1);

[is_boundary, boundary_list_idx] = ismember([row_mask, col_mask], boundary, 'rows');

elementInDiag = ones (num_of_hole_pixels, 1)*4;
A = spdiags (elementInDiag, 0, num_of_hole_pixels, num_of_hole_pixels);%Extract and create sparse band and diagonal matrices

%subtract neighbor connections (Laplace with a 4-conn neighborhood)
A = A - AdjacencyMat;
for i=1:num_of_hole_pixels
    A(i,i)= -(sum(A(i,:))-4);
end
for i=1:length(row_mask)
    if(ismember([row_mask(i), col_mask(i)], boundary, 'rows'))
        A(i,i)=4;
    end
end
boundary_list_idx(boundary_list_idx==0) = [];
%now we create b
%we assume that Targ has Gx+Gy pasted within the hole defined by MaskTarg
b = Targ(sub2ind(size(Targ), row_mask, col_mask));
% b = zeros(num_of_hole_pixels, 1);
;%remove zero entries
%b(is_boundary)=sum_boundary(boundary_list_idx);
b(is_boundary) = b(is_boundary) + sum_boundary(boundary_list_idx);%边界的条件

%Starting point
x0 = mean(sum_boundary./Np_boundary)*ones(num_of_hole_pixels, 1);
%Solve using conjagant gradient descent %迭代法求解稀疏线性方程组
%   X = CGS(A,B) attempts to solve the system of linear equations A*X=B for
%   X. The N*N coefficient matrix A must be square and the right hand
%   side column vector B must have length N.
X = cgs(sparse(A), b, tolerance, max_iter, [], [], x0);
%X = cgs(sparse(A), b);
Targ_filled = Targ;
%fill in mask with result, clipp with zero from below to prevent small
%negative numbers
Targ_filled(sub2ind(size(Targ), row_mask, col_mask)) = max(X, 0);

end

