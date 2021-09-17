# Laplacian-filtering-for-images
Implement Laplacian filtering to achieve edge detection.

## Steps for Frequency domain filtering
  1. read Image to double
  2. Padding & Centering 
  3. 2D Fourier transform (DFT) to get **F(u,v)** 
  4. Design Laplacian filter  
     ![image](https://user-images.githubusercontent.com/78803926/133756906-866e74bf-31e2-47fd-a458-0258c51d497e.png)  
  6. Apply filtering  
     ![image](https://user-images.githubusercontent.com/78803926/133756944-d1434318-59ab-4588-9536-ddf3f9e0d4ea.png)

  8. Inverse 2D DFT  
     ![image](https://user-images.githubusercontent.com/78803926/133757184-7e3c299d-f15e-4c82-aa6e-7d62caddf4cd.png)

  10. Centering again
  11. Export image  

## Execution  
Note: Set the path of image before execution  
  ![image](https://user-images.githubusercontent.com/78803926/133754991-7adf525f-db1a-43fd-a027-0cb9e1debd1c.png)  
  
## Results  
![image](https://user-images.githubusercontent.com/78803926/133758565-f3849e53-a0ff-45b0-b8ab-2d139773874a.png)

  

