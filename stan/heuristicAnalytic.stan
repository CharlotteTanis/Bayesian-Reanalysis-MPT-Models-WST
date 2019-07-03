// Heuristic analytic model
data {
  int<lower=0> k[16];
}
parameters {
  real<lower=0,upper=1> p;
  real<lower=0,upper=1> np;
  real<lower=0,upper=1> q;
  real<lower=0,upper=1> nq;
  real<lower=0,upper=1> c;
  real<lower=0,upper=1> d;
  real<lower=0,upper=1> s;
  real<lower=0,upper=1> x;
  real<lower=0,upper=1> i;
}
transformed parameters {
  simplex[16] theta;
  
  // MPT Category Probabilities
  theta[1] = (1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*s*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*d*s*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*s*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*c*d*s*i+(1-p)*(1-np)*q*(1-nq)*c*d*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*nq*c*d*(1-s)*i+(1-p)*(1-np)*q*nq*c*d*s*i+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*s*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*(1-nq)*c*d*s*i+(1-p)*np*(1-q)*(1-nq)*c*d*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*s*i+(1-p)*np*(1-q)*nq*c*(1-d)*s*i+(1-p)*np*(1-q)*nq*c*d*s*i+(1-p)*np*(1-q)*nq*(1-c)*x*s*i+(1-p)*np*q*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*np*q*(1-nq)*c*d*s*i+(1-p)*np*q*(1-nq)*c*d*s*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*np*q*nq*c*d*s*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*s*i+p*(1-np)*(1-q)*nq*c*d*(1-s)*i+p*(1-np)*(1-q)*nq*c*d*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*s*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*i+p*(1-np)*q*(1-nq)*c*d*(1-s)*i+p*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*i+p*(1-np)*q*nq*c*d*(1-s)*i+p*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+p*np*(1-q)*(1-nq)*c*(1-d)*s*i+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*(1-q)*nq*c*(1-d)*s*i+p*np*q*(1-nq)*c*(1-d)*(1-s)*i;
  theta[2] = (1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*c*d*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-s)*i+(1-p)*(1-np)*q*nq*(1-c)*x*(1-s)*i+(1-p)*(1-np)*q*nq*c*d*s*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-s)*i+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*nq*c*d*s*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-s)*i+(1-p)*np*q*nq*c*d*s*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*i+p*(1-np)*q*nq*c*(1-d)*(1-s)*i+p*(1-np)*q*nq*(1-c)*x*(1-s)*i+p*np*(1-q)*nq*c*(1-d)*(1-s)*i+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*(1-s)*i;
  theta[3] = (1-p)*(1-np)*q*(1-nq)*c*(1-d)*s*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*s*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*s*i+(1-p)*(1-np)*q*nq*c*d*(1-s)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*s*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*s*i+(1-p)*np*q*(1-nq)*c*(1-d)*s*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*q*(1-nq)*(1-c)*x*s*i+(1-p)*np*q*nq*c*(1-d)*s*i+(1-p)*np*q*nq*(1-c)*x*s*i+p*(1-np)*q*(1-nq)*c*(1-d)*s*i+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*(1-nq)*c*d*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*s*(1-i)+p*(1-np)*q*nq*c*(1-d)*s*i+p*(1-np)*q*nq*c*d*(1-s)*(1-i)+p*(1-np)*q*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*(1-d)*s*i+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*s*i;
  theta[4] = (1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*nq*(1-c)*x*s*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*(1-c)*(1-x)*(1-d)*i;
  theta[5] = (1-p)*np*(1-q)*(1-nq)*c*d*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*(1-q)*nq*c*d*(1-s)*i+(1-p)*np*(1-q)*nq*c*d*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*s*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*np*q*(1-nq)*c*d*(1-s)*i+(1-p)*np*q*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*q*nq*c*d*(1-s)*i+(1-p)*np*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*(1-s)*i+p*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+p*np*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+p*np*(1-q)*nq*c*d*(1-s)*i+p*np*(1-q)*nq*c*d*(1-s)*(1-i)+p*np*(1-q)*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*d*(1-s)*i+p*np*q*(1-nq)*(1-c)*x*(1-s)*i+p*np*q*nq*c*d*(1-s)*i;
  theta[6] = (1-p)*np*(1-q)*nq*(1-c)*x*(1-s)*i+(1-p)*np*(1-q)*nq*(1-c)*x*s*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-s)*i+p*np*(1-q)*nq*(1-c)*x*(1-s)*i+p*np*q*nq*(1-c)*x*(1-s)*i;
  theta[7] = (1-p)*np*q*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*c*d*(1-s)*(1-i)+(1-p)*np*q*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*d*(1-s)*(1-i)+p*np*q*(1-nq)*c*(1-d)*s*(1-i)+p*np*q*nq*c*d*(1-s)*(1-i)+p*np*q*nq*c*(1-d)*s*(1-i);
  theta[8] = (1-p)*np*q*nq*(1-c)*x*s*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i);
  theta[9] = p*(1-np)*(1-q)*(1-nq)*c*d*s*i+p*(1-np)*(1-q)*(1-nq)*c*d*s*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*(1-q)*nq*c*d*s*i+p*(1-np)*(1-q)*nq*(1-c)*x*s*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+p*(1-np)*q*(1-nq)*c*d*s*i+p*(1-np)*q*(1-nq)*c*d*s*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*q*nq*c*d*s*i+p*(1-np)*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*s*i+p*np*(1-q)*(1-nq)*c*d*s*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*s*i+p*np*(1-q)*nq*c*d*s*i+p*np*(1-q)*nq*(1-c)*x*s*i+p*np*q*(1-nq)*c*d*s*i+p*np*q*(1-nq)*c*d*s*(1-i)+p*np*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*np*q*nq*c*d*s*i;
  theta[10] = p*(1-np)*(1-q)*nq*c*d*s*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*s*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*c*d*s*(1-i)+p*(1-np)*q*nq*c*(1-d)*(1-s)*(1-i)+p*np*(1-q)*nq*c*d*s*(1-i)+p*np*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+p*np*q*nq*c*d*s*(1-i)+p*np*q*nq*c*(1-d)*(1-s)*(1-i);
  theta[11] = p*(1-np)*q*(1-nq)*(1-c)*x*s*i+p*(1-np)*q*(1-nq)*(1-c)*x*s*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*(1-c)*x*s*i+p*np*q*(1-nq)*(1-c)*x*s*i+p*np*q*nq*(1-c)*x*s*i;
  theta[12] = p*(1-np)*q*nq*(1-c)*x*s*(1-i)+p*(1-np)*q*nq*(1-c)*x*(1-s)*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i);
  theta[13] = p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*i+p*np*q*(1-nq)*(1-c)*(1-x)*d*i+p*np*q*nq*(1-c)*(1-x)*d*i;
  theta[14] = p*np*(1-q)*nq*(1-c)*x*s*(1-i)+p*np*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i);
  theta[15] = p*np*q*(1-nq)*(1-c)*x*s*(1-i)+p*np*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i);
  theta[16] = p*np*q*nq*(1-c)*x*s*(1-i)+p*np*q*nq*(1-c)*x*(1-s)*(1-i)+p*np*q*nq*(1-c)*(1-x)*d*(1-i)+p*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i);
}
model {
  // Priors
  target += beta_lpdf(p | 1, 1);
  target += beta_lpdf(np | 1, 1);
  target += beta_lpdf(q | 1, 1);
  target += beta_lpdf(nq | 1, 1);
  target += beta_lpdf(c | 1, 1);
  target += beta_lpdf(d | 1, 1);
  target += beta_lpdf(s | 1, 1);
  target += beta_lpdf(x | 1, 1);
  target += beta_lpdf(i | 1, 1);

  // Data
  target += multinomial_lpmf(k | theta);
}
