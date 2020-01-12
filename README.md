
# Efficient Design of FIR filter using G_best Guided Cuckoo Search Algorithm

This is a part of my Bachelor Project. 

# Abstract: 
This paper presents an efficient design of Finite Impulse Response (FIR) filter using Gbestguided Cuckoo Search (GCS) algorithm. To reduce the parameter dependency in traditional Cuckoo Search Algorithm (CSA) as well as better searching of optimal coefficient in the filter designing problems, some modification in the approach of CSA is done in the proposed GCS, which results in a noteworthy faster convergence with an optimal solution. Here, low-pass and band-pass filters are designed, for both Type1 and Type 2 FIR, using GCS, CSA, and Artificial Bee Colony (ABC) algorithm. From the graphical and statistical observations of GCS, CSA, and ABC, it is clear that GCS surpass its competitors in terms of convergence rate, execution time, and filter response. Furthermore, the stop-band attenuation (As ) and pass-band ripple (Rp) obtained for the filters developed using the proposed GCS is much better than that designed using CSA, ABC or, Parks and McClellan method. An average study suggests that GCS shows 9.23% increase in s A and 26.05% decrease in p R for lower order LPF(for both Type 1 and Type 2, order less than 40); 4.27% increase in As and 18.85% decrease in Rp for higher order LPF(for both Type 1 and Type 2, order greater than 40 and less than 100); 32.47% increase in As and 28.18% decrease in Rp for lower order BPF(for both Type 1 and Type 2, order less than 40); 6.92% increase in As and 10.44% decrease in Rp for higher order BPF(for both Type 1 and Type 2,order greater than 40 and less than 100), compared to PM.


# P.S. This repo contains only the code for the BPF 

