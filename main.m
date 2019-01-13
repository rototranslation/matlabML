%Loading data
data = csvread('dataset.csv');

%PCA
[matx, eigList, projection] = PCA(data, 5);
figure;
scatter(1:5, abs(matx(:,1)));
title("PCA");

%Discarding less meaningful attribute
myset = data;
myset(:,2) = [];
Y = myset(:, 4);
myset(:, 4) = [];
figure;
scatter3(myset(:,1), myset(:,2), myset(:,3), 25, Y);
xlabel("Counting Trust");
ylabel("Last Time");
zlabel("Transaction Context");
title("Dataset");

%Hierarchical clustering - Average Linkage
[centers, groups] = hierarchicalClustering(myset, 2);

%2D graph
% figure;
% hold on;
% scatter3(myset(groups == 1,1), myset(groups == 1,2), myset(groups == 1,3), 25, 'og');
% scatter3(myset(groups ~= 1,1), myset(groups ~= 1,2), myset(groups ~= 1,3), 25, 'om');
% scatter3(centers(:,1), centers(:,2), centers(:,3), 25, 'rX');
% title("Hierarchical Clustering: Green=Trust | Magenta=Untrust");
% xlabel("Counting Trust");
% ylabel("Last Time");
% zlabel("Transaction Context");
% hold off;

%3D graph
figure;
view(3);
grid on;
hold on;
scatter3(myset(groups == 1,1), myset(groups == 1,2), myset(groups == 1,3), 25, 'og');
scatter3(myset(groups ~= 1,1), myset(groups ~= 1,2), myset(groups ~= 1,3), 25, 'om');
scatter3(centers(:,1), centers(:,2), centers(:,3), 25, 'rX');
title("Hierarchical Clustering 3D");
xlabel("Counting Trust");
ylabel("Last Time");
zlabel("Transaction Context");
hold off;

%Matlab Style - Hierarchical clustering dendrogram
tree = linkage(myset, 'a');
figure;
dendrogram(tree);
title("Hierarchical Cluster (Dendrogram)");

%Printing number of points in group1(Trusty) and groups2(Untrusty)
gONE = 0;
for i = 1:size(groups)
    if groups(i) == 1
        gONE = gONE+1;
    end
end
 gONE
 gTWO = 322-gONE

%Wrong points in Hierarchical clustering
[hierarchicalErrors, ~] = size(groups(groups ~= Y))
hierarchicalErrorsPerc = hierarchicalErrors*100/322

%Spectral Clustering
k = 210;
[eigenVect, groups] = spectralClustering(myset, k, 2);
ar = [];
for i = 1:size(eigenVect)
    ar = [ar, i];
end

%Eigen vector
figure;
grid on;
scatter(ar', eigenVect, 25 );
title(['Eigen Vector | K = ' num2str(k)]);

%2D graph
% figure;
% hold on;
% scatter3(myset(groups == 1,1), myset(groups == 1,2), myset(groups == 1,3), 25, 'og');
% scatter3(myset(groups ~= 1,1), myset(groups ~= 1,2), myset(groups ~= 1,3), 25, 'om');
% title('Spectral cluster');
% xlabel("Counting Trust");
% ylabel("Last Time");
% zlabel("Transaction Context");
% hold off;

%3D graph
figure;
view(3);
grid on;
hold on;
scatter3(myset(groups == 1,1), myset(groups == 1,2), myset(groups == 1,3), 25, 'og');
scatter3(myset(groups ~= 1,1), myset(groups ~= 1,2), myset(groups ~= 1,3), 25, 'om');
title(['Spectral cluster 3D | K = ' num2str(k)]);
xlabel("Counting Trust");
ylabel("Last Time");
zlabel("Transaction Context");
hold off;

%Printing number of points in group1(Trusty) and groups2(Untrusty)
gONE = 0;
for i = 1:size(groups)
    if groups(i) == 1
        gONE = gONE+1;
    end
end
 gONE
 gTWO = 322-gONE

%Wrong points in Spectral clustering
[spectralErrors, ~] = size(groups(groups ~= Y))
spectralErrorsPerc = spectralErrors*100/322