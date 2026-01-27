# Evaluation of sparsity metrics and evolutionary algorithms applied for normalization of H&E histological images

This repository contains the source code of the paper entitled "Evaluation of sparsity metrics and evolutionary algorithms applied for normalization of H&E histological images" https://doi.org/10.1007/s10044-024-01218-7.

## Structure
- Main function: is an editable source code for stain normalization of H&E images with definition of (i) the target image, (ii) the evolutionary algorithm with a sparsity function, and (iii) the source images folder path. The Natural-Order Filename Sort can be found on [MATLAB File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/47434-natural-order-filename-sort);
- Evolutionary algorithms: the ABC, CS, DE, GA, PSO, and WDO are encrypted source code, but with outputs and inputs specified in the main function for use;
- Auxiliary functions: the remaining encrypted source codes are responsible for the estimation of the stain color appearance matrix and stain density maps;
- The target image is from the [GlaS Contest](https://www.kaggle.com/datasets/sani84/glasmiccai2015-gland-segmentation).

## Citation
For use and distribution, please cite:
```bibtex
@article{tosta2024evaluation,
  title={Evaluation of sparsity metrics and evolutionary algorithms applied for normalization of H\&E histological images},
  author={Tosta, Tha{\'\i}na A Azevedo and de Faria, Paulo Rog{\'e}rio and Neves, Leandro Alves and Martins, Alessandro Santana and Kaushal, Chetna and do Nascimento, Marcelo Zanchetta},
  journal={Pattern Analysis and Applications},
  volume={27},
  number={1},
  pages={11},
  year={2024},
  publisher={Springer}
}
