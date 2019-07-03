// Inference guessing model relaxed version
data {
  int<lower=0> k[16];
}
parameters {
  real<lower=0,upper=1> p;
  real<lower=0,upper=1> np;
  real<lower=0,upper=1> q;
  real<lower=0,upper=1> nq;
  real<lower=0,upper=1> a;
  real<lower=0,upper=1> c;
  real<lower=0,upper=1> d;
  real<lower=0,upper=1> sf;
  real<lower=0,upper=1> sb;
  real<lower=0,upper=1> sfb;
  real<lower=0,upper=1> x;
  real<lower=0,upper=1> i;
}
transformed parameters {
  simplex[16] theta;
  
  // MPT Category Probabilities
  theta[1] = (1 - a) * (1 - p) * (1 - np) * (1 - q) * (1 - nq);  // 0000
  theta[2] = a * c * (1 - d) * (1 - sb) * i + (1 - a) * (1 - p) * (1 - np) * (1 - q) * nq;  // 0001
  theta[3] = a * c * (1 - d) * sb * i + (1 - a) * (1 - p) * (1 - np) * q * (1 - nq);  // 0010
  theta[4] = a * (1 - c) * (1 - x) * (1 - d) * i + (1 - a) * (1 - p) * (1 - np) * q * nq;  // 0011
  theta[5] = a * c * d * (1 - sf) * i + (1 - a) * (1 - p) * np * (1 - q) * (1 - nq);  // 0100
  theta[6] = a * (1 - c) * x * (1 - sfb) * i + (1 - a) * (1 - p) * np * (1 - q) * nq;  // 0101
  theta[7] = a * c * d * (1 - sf) * (1 - i) + a * c * (1 - d) * sb * (1 - i) + (1 - a) * (1 - p) * np * q * (1 - nq);  // 0110
  theta[8] = (1 - a) * (1 - p) * np * q * nq;  // 0111
  theta[9] = a * c * d * sf * i + (1 - a) * p * (1 - np) * (1 - q) * (1 - nq);  // 1000
  theta[10] = a * c * d * sf * (1 - i) + a * c * (1 - d) * (1 - sb) * (1 - i) + (1 - a) * p * (1 - np) * (1 - q) * nq;  // 1001
  theta[11] = a * (1 - c) * x * sfb * i + (1 - a) * p * (1 - np) * q * (1 - nq);  // 1010
  theta[12] = (1 - a) * p * (1 - np) * q * nq;  // 1011
  theta[13] = a * (1 - c) * (1 - x) * d * i + (1 - a) * p * np * (1 - q) * (1 - nq);  // 1100
  theta[14] = (1 - a) * p * np * (1 - q) * nq;  // 1101
  theta[15] = (1 - a) * p * np * q * (1 - nq);  // 1110
  theta[16] = a * (1 - c) * x * sfb * (1 - i) + a * (1 - c) * x * (1 - sfb) * (1 - i) + a * (1 - c) * (1 - x) * d * (1 - i) + a * (1 - c) * (1 - x) * (1 - d) * (1 - i) + (1 - a) * p * np * q * nq;  // 1111
}
model {
  // Priors
  target += beta_lpdf(p | 1, 1);
  target += beta_lpdf(np | 1, 1);
  target += beta_lpdf(q | 1, 1);
  target += beta_lpdf(nq | 1, 1);
  target += beta_lpdf(a | 1, 1);
  target += beta_lpdf(c | 1, 1);
  target += beta_lpdf(d | 1, 1);
  target += beta_lpdf(sf | 1, 1);
  target += beta_lpdf(sb | 1, 1);
  target += beta_lpdf(sfb | 1, 1);
  target += beta_lpdf(x | 1, 1);
  target += beta_lpdf(i | 1, 1);

  // Data
  target += multinomial_lpmf(k | theta);
}
