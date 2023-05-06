# multicolumn
This repository contains codes for multicolumnar model paper.

### Folders
- `figs`: contains figures for temporary results. (not necessary)
- `funcs`: contains functions used in study. Usually be called from scripts in other folders.
- `plots`: contains scripts for generate figures in `figs` folder. Code for good figures will be later copied and pasted to codes for paper. (not necessary)
- `traverse_in_space`: contains codes for traversing parameter space, and save the data locally.
- `study`: contains scripts to study the data of space traversing. 
    - `disruptOrder.mlx`: try to explain what factor disrupt the ordered pattern.

### To explain disrupt order:
#### from unstable to stable
- Short time period analysis: the dynamics of PET
- Integrate time analysis: integration of PET

#### From stable gamma+beta to stable gamma
- Short time period analysis: Find different pattern of PET
- Integrate time analysis: integration of PET

### Notes:
- `data` is saved locally and can be found in parent folder.
- `paper` is saved locally and can be found in parent folder.
- `pathway current`, or `pathway energy transimssion (PET)` are matrix of (16,16), where (x,y) means the pathway from population y to population x. e.g. (10,1) means the pathway from the population idx 1 (1L2/3E) to the population idx 10 (2L2/3I).

