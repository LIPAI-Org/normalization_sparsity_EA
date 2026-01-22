nstains = 2; %Parameter: number of dyes (Hematoxylin-Eosin)
%ABC: [lambda, best_nectar_food_source, number_of_iterations, execution_time] = ABC(img_histogram, number_food_sources, fuzzy_parameters, limit_scout_bees, sparsity_function)
%CS: [lambda, best_nest, number_of_iterations, execution_time] = CS(img_histogram, number_nests, fuzzy_parameters, discovery_prob, sparsity_function)
%DE: [lambda, fitness_best_individual, number_of_iterations, execution_time] = DE(img_histogram, population, fuzzy_parameters, crossover_constant, F, sparsity_function)
%GA: [lambda, best_individual, number_of_iterations, execution_time] = GA(img_histogram, population, fuzzy_parameters, crossover_prob, mutation_prob, sparsity_function)
%PSO: [lambda, fitness_function_gBest, number_of_iterations, execution_time] = PSO(img_histogram, number_particles, fuzzy_parameters, velocity_clamping_factor, cognitive_constant, social_constant, inertia_factor, sparsity_function (sparsity_l2l1, sparsity_hoyer, sparsity_k4 or sparsity_le))
%WDO: [lambda, globalpressure, number_of_interations, execution_time] = lambda_evaluation_WDO(img_histogram, population, fuzzy_parameters, RT, gravitational_constant, alpha, coriolis_effect, maxVelocity, sparsity_function)

target = imread('C:\Users\tosta\OneDrive\Área de Trabalho\Tosta et al. 2024\target.bmp'); %Parameter: Target image for normalization 
Wtarget_initialization = W_initialization(target);
for i = 1 : size(Wtarget_initialization,2)
    Wtarget_initialization(:,i) = Wtarget_initialization(:,i)/norm(Wtarget_initialization(:,i), 2);
end
p = imhist(rgb2gray(target));
[Vtarget_raw,Vtarget_forW] = beer_lambert_transformation(target); 
lambda = PSO(p,250, 3, 2, 2, 2, 1, 'sparsity_l2l1');
Wtarget = W_estimation(Wtarget_initialization, Vtarget_forW, nstains, lambda, round(0.001*size(Vtarget_forW,1))); %Parameter: The minibatch can be adjusted (0.001)
[Htarget,~] = H_estimation(Vtarget_raw, Wtarget, size(target,1), size(target,2));

folder = 'C:\Users\tosta\OneDrive\Área de Trabalho\Tosta et al. 2024\samples'; %The source image folder
files = dir(fullfile(folder, '*.tif'));
fileNames = natsortfiles({files.name});
total = numel(files);
for m=1:total
	full_name_org = fullfile(folder, fileNames(1,m));
	source = imread(char(full_name_org));
	p = imhist(rgb2gray(source));
    lambda = PSO(p,250, 3, 2, 2, 2, 1, 'sparsity_l2l1');
	Wsource_initialization = W_initialization(source);
	for i = 1 : size(Wsource_initialization,2)
        Wsource_initialization(:,i) = Wsource_initialization(:,i)/norm(Wsource_initialization(:,i), 2);
    end
	[Vsource_raw,Vsource_forW] = beer_lambert_transformation(source);
	Wsource = W_estimation(Wsource_initialization, Vsource_forW, nstains, lambda, round(0.001*size(Vsource_forW,1))); %Parameter: The minibatch can be adjusted (0.001)
	[Hsource,~] = H_estimation(Vsource_raw, Wsource, size(source,1), size(source,2));
	[norm_version] = norm_image_generation(source,Htarget,Wtarget,Hsource);
    [~,name,~] = fileparts(char(full_name_org));
    filename = strcat('C:\Users\tosta\OneDrive\Área de Trabalho\Tosta et al. 2024\results\',name,'.png');
    imwrite(norm_version,filename);
end
