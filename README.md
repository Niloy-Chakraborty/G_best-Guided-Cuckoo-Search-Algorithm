
### Efficient Design of FIR filter using G_best Guided Cuckoo Search Algorithm

This work is a part of my Bachelor Thesis. 

#### Abstract: 
-------------
This Repository presents an efficient design of **Finite Impulse Response (FIR) filter** using **G-best guided Cuckoo Search (GCS)** algorithm. To reduce the parameter dependency in traditional **Cuckoo Search Algorithm (CSA)** as well as better searching of optimal coefficient in the filter designing problems, some modification in the approach of CSA is done in the proposed GCS, which results in a noteworthy faster convergence with an optimal solution. Here, both low-pass and band-pass filters have been designed, for both Type1 and Type 2 FIR, using **GCS**, **CSA**, and **Artificial Bee Colony (ABC)** algorithm.

#### Result:
-------------
From the graphical and statistical observations ([here](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/blob/master/Efficient%20Design%20of%20FIR%20filter%20using%20G_best%20Guided%20Cuckoo%20Search%20Algorithm.pdf)) of **GCS, CSA, and ABC**, it is clear that **GCS** surpass its competitors in terms of **convergence rate, execution time, and filter response**. 

![Convergence](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/blob/master/Convergence.png)

Furthermore, the **stop-band attenuation (As )** and **pass-band ripple (Rp)** obtained for the filters developed using the proposed GCS is much better than that designed using CSA, ABC or, Parks and McClellan method.

An average study suggests that GCS shows **9.23%** increase in s A and **26.05%** decrease in p R for lower order LPF(for both Type 1 and Type 2, order less than 40); **4.27%** increase in As and **18.85%** decrease in Rp for higher order LPF(for both Type 1 and Type 2, order greater than 40 and less than 100); **32.47%** increase in As and **28.18%** decrease in Rp for lower order BPF(for both Type 1 and Type 2, order less than 40); **6.92%** increase in As and **10.44%** decrease in Rp for higher order BPF(for both Type 1 and Type 2,order greater than 40 and less than 100), compared to PM.

#### GuideLines For this Repository
----------------------------------
1. For GCS BPF-Type1 Filter, go to [this](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/tree/master/Type1%20Band%20Pass%20Filter/type%201%20icsa%20bandpass%20order) folder
2.  For GCS BPF-Type2 Filter, go to [this](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/tree/master/Type2%20Band%20Pass%20Filter/Improved%20CSA%20type%202%20bp) folder
3. For Cuckoo Search Algorithm , Go to [here](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/tree/master/Type1%20Band%20Pass%20Filter/type%201%20csa%20band%20pass%20order) for Type 1 BPF and [here](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/tree/master/Type2%20Band%20Pass%20Filter/CSA%20Type%202%20bp%20order) for Type 2 BPF
4. Artificial Bee Colony codes are available as well. Go to [here](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/tree/master/Type1%20Band%20Pass%20Filter/type%201%20abc%20band%20pass%20order) for Type 1 BPF and [here](https://github.com/Niloy-Chakraborty/G_best-Guided-Cuckoo-Search-Algorithm/tree/master/Type2%20Band%20Pass%20Filter/ABC%20Type%202%20bp%20order) for Type 2 BPF


##### P.S.
**1. This repo contains only the code for the BPF.**

**2. Ensure that you have installed Matlab and have CPU with sufficient RAM (>=4GB).**


