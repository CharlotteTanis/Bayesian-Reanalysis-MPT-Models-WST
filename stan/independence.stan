// Independence model
data {
  int<lower=0> k[16];
}
parameters {
  real<lower=0,upper=1> p;
  real<lower=0,upper=1> np;
  real<lower=0,upper=1> q;
  real<lower=0,upper=1> nq;
}
transformed parameters {
  simplex[16] theta;

  // MPT Category Probabilities
  theta[1] = (1 - p) * (1 - np) * (1 - q) * (1 - nq);  // 0000
  theta[2] = (1 - p) * (1 - np) * (1 - q) * nq;        // 0001
  theta[3] = (1 - p) * (1 - np) * q * (1 - nq);        // 0010
  theta[4] = (1 - p) * (1 - np) * q * nq;              // 0011
  theta[5] = (1 - p) * np * (1 - q) * (1 - nq);        // 0100
  theta[6] = (1 - p) * np * (1 - q) * nq;              // 0101
  theta[7] = (1 - p) * np * q * (1 - nq);              // 0110
  theta[8] = (1 - p) * np * q * nq;                    // 0111
  theta[9] = p * (1 - np) * (1 - q) * (1 - nq);        // 1000
  theta[10] = p * (1 - np) * (1 - q) * nq;             // 1001
  theta[11] = p * (1 - np) * q * (1 - nq);             // 1010
  theta[12] = p * (1 - np) * q * nq;                   // 1011
  theta[13] = p * np * (1 - q) * (1 - nq);             // 1100
  theta[14] = p * np * (1 - q) * nq;                   // 1101
  theta[15] = p * np * q * (1 - nq);                   // 1110
  theta[16] = p * np * q * nq;                         // 1111
}
model {
  // Priors
  target += beta_lpdf(p | 1, 1);
  target += beta_lpdf(np | 1, 1);
  target += beta_lpdf(q | 1, 1);
  target += beta_lpdf(nq | 1, 1);
  
  // Data
  target += multinomial_lpmf(k | theta);
}
