load ship_1.mat
X = abs_ifft_ship_1; % 150行4列
meanX = ones(size(X,1), 1) * mean(X);
centredX = X - meanX;
C = cov(centredX); % 直接调用cov直接计算协方差矩阵即可
[W, Lambda] = eig(C); % W是特征向量组成的矩阵（4×4），Lambda是特征值组成的对角矩阵

ev = (diag(Lambda))'; % 提取特征值

ev = ev(:, end:-1:1); % eig计算出的特征值是升序的，这里手动倒序（W同理）

W = W(:, end:-1:1);

sum(W.*W, 1) % 可以验证每个特征向量各元素的平方和均为1

Wr = W(:, 1:50); % 提取前两个主成分的特征向量

Tr = centredX * Wr; % 新坐标空间的数据点