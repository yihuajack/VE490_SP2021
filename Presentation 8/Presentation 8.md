# Presentation 8 Part 2

## 1. Concepts

### 1.1 Boundary Load

Use a **Boundary Load** to apply tractions or pressure to boundaries.

#### FORCE

Select a **Load type** — **Force per unit area** (the default), **Pressure**, **Total force**, or for 2D components, **Force per unit length**. Then enter values or expressions for the components in the matrix based on the selection and the space dimension.

<table border="1">
<tr>
<td>•</td>
<td>For <b>Force per unit area</b>, the body load as force per unit volume is then the value of <i>F</i> divided by the thickness.</td>
</tr>
<tr>
<td>•</td>
<td>For <b>Total force</b>, COMSOL Multiphysics then divides the total force by the area of the surfaces where the load is active</td>
</tr>
<tr>
<td>•</td>
<td>For <b>Pressure</b>, it can represent a pressure or another external pressure. The pressure is positive when directed toward the solid.</td>
</tr>
<tr>
<td><img src="https://doc.comsol.com/5.5/doc/com.comsol.help.comsol/images/comsol_ref_structuralmechanics.22.15.1.png"/></td>
<td>After selecting a <b>Load type</b>, the <b>Load</b> list normally only contains <b>User defined</b>. When combining with another physics interface that can provide this type of load, it is also possible to choose a predefined load from this list.</td>
</tr>
</table>

| LOAD TYPE             | VARIABLE                  | SI UNIT          | GEOMETRIC ENTITY LEVEL | SPACE DIMENSION (COMPONENTS)                            |
| --------------------- | ------------------------- | ---------------- | ---------------------- | ------------------------------------------------------- |
| Force per unit area   | $\mathbf{F}_\mathrm{A}$   | $\mathrm{N/m^2}$ | boundaries             | 3D (x, y, z)<br />2D (x, y)<br />2D axisymmetric (r, z) |
| Force per unit length | $\mathbf{F}_\mathrm{L}$   | $\mathrm{N/m}$   | boundaries             | 2D (x, y)                                               |
| Total force           | $\mathbf{F}_\mathrm{tot}$ | $\mathrm{N}$     | boundaries             | 3D (x, y, z)<br />2D (x, y)<br />2D axisymmetric (r, z) |
| Pressure              | $p$                       | $\mathrm{Pa}$    | boundaries             | 3D (x, y, z)<br />2D (x, y)<br />2D axisymmetric (r, z) |

#### LOCATION IN USER INTERFACE

##### *Context Menus*

**Solid Mechanics**>**Body Load**

##### *Ribbon*

Physics Tab with **Solid Mechanics** selected:

**Boundaries**>**Solid Mechanics**>**Body Load**

### 1.2 Structural Mechanics

The structural deformations are solved for using an elastic formulation and a nonlinear geometry formulation to allow large deformations.
The obstacle is fixed to the bottom of the fluid channel. All other object boundaries experience a load from the fluid 【障碍物的其他所有边界都承受流体施加的载荷】, given by

$\mathbf{F}_\mathrm{T}=-\mathbf{n}\cdot(-p\mathbf{I}+\eta(\nabla\mathbf{u}+(\nabla\mathbf{u})^T))$

where $\mathbf{n}$ is the normal vector to the boundary. This load represents a sum of pressure and viscous forces.

## 2. COMSOL Simulation

### 2.1  Power  measured in pressure integral

Doing Line Integration on Selection 60 (the outlet border):

![image-20210413123953148](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413123953148.png)

Here the Method in Integration Settings should be Integration or Auto (which will automatically choose Integration) but not Summation over nodes, or the derived values are measured in Pa, and we can see a warning: "Using summation is not recommended for this expression: p". However, for Data Series Operation, it is the operation on data series, so the direct way is to maintain "None". For example, if you want to derive the average of the data series, choose "Average", and you will get only one row of data that is the average. Evaluate in Table 6:

![image-20210413124113021](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413124113021.png)

Export it:

![image-20210413135233150](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413135233150.png)

we have when $t=0.05$ s, integral of a general expression over an interval (N/m) is 2.0246603839193396E-7+1.5077672276753085E-6i.

Alternatively, we can create a 1D Plot Group and manually calculate the integral as follows.

![image-20210413135015344](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413135015344.png)

Of course, there are better ways to achieve this. Here the Arc length is just the Selection 60 (the outlet border). Right Click the plot and click "Add Plot Data to Export", we export the plot data to file.

![image-20210413135159086](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413135159086.png)

when $x=99.99999999999997$, the height of the line graph is 2.0247125550835613E-7, just what we get before excluding the imaginary part.

### 2.2 Resistance measured in boundary load integral

We do a parameter sweep to find at which velocity the boundary load integral is equal to 2E-7 N/m.

We first use 10^{range(log10(0.001),1/1,log10(10))} as the Parameter value list and then narrow it to range(1,2.25,10) and range(3,0.625,5.5). Finally, we use range(5.5,0.1,6).

After the computation is finished, we create Line Integration 1 and Line Integration 2.

![image-20210413141756236](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413141756236.png)

![image-20210413141820274](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413141820274.png)

Evaluate in Load Integral 1 and Load Integral 2 tables respectively:

![image-20210413142311030](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413142311030.png)

![image-20210413142229878](D:\Documents\GitHub\VE490_SP2021\Presentation 8\image-20210413142229878.png)

Right click and click "Add Table to Export". In exported table, we have when time is 4s and $U=5.9\,\mu\mathrm{m/s}$, the difference of Normal load, x component (N/m) is 2.3576235388126245E-7-3.4808350881015064E-8=2.00954003, and when $U=5.8\,\mu\mathrm{m/s}$, the difference of Normal load, x component (N/m) is 2.317663762267406E-7-3.42183732226208E-8=1.97548003.

Hence, the equilibrium velocity is $5.9\,\mu\mathrm{m/s}$.