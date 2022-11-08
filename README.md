# Discontinous Galerkin Method

This is is a project I did in University.  

The goals was to implement a simple [Disconntious Galerkin](https://en.wikipedia.org/wiki/Discontinuous_Galerkin_method) solver in 1D for the [acoustic wave equation](https://en.wikipedia.org/wiki/Acoustic_wave_equation):

$$
\begin{align}
	\rho \frac{\partial \boldsymbol{v}}{\partial t} + \nabla p =0         \\
	\frac{1}{c^2} \frac{\nabla p}{t} + \rho \nabla \cdot \boldsymbol{v} =0 
\end{align}
$$

**NOTE:** Personally, I would never choose Matlab for any kind of project. **It's a terrible language**. However, it was mandatory for this university project.


Check out the [final_report](reort/build/../../report/build/report_project2.pdf) for a comprehensive explanation and results.

![](https://awesomescreenshot.s3.amazonaws.com/image/3871678/34157159-aab6d01bd03fee676eee1672352cbc39.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJSCJQ2NM3XLFPVKA%2F20221107%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20221107T222529Z&X-Amz-Expires=28800&X-Amz-SignedHeaders=host&X-Amz-Signature=aa188be7c994ab1507c9961680a861230f5226d48228712b733022f28f6d8643)
