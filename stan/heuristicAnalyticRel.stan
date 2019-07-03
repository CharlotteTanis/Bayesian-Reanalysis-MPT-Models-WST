// Heuristic analytic model relaxed version
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
  real<lower=0,upper=1> sf;
  real<lower=0,upper=1> sb;
  real<lower=0,upper=1> sfb;
  real<lower=0,upper=1> x;
  real<lower=0,upper=1> i;
}
transformed parameters {
  simplex[16] theta;
  
  // MPT Category Probabilities
  theta[1] = (1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*sf*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*sf*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*sb*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-sf)*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*d*sf*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*sfb*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-sf)*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*q*(1-nq)*c*d*sf*i+(1-p)*(1-np)*q*(1-nq)*c*d*sf*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*nq*c*d*(1-sf)*i+(1-p)*(1-np)*q*nq*c*d*sf*i+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*sb*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*(1-nq)*c*d*sf*i+(1-p)*np*(1-q)*(1-nq)*c*d*sf*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*sfb*i+(1-p)*np*(1-q)*nq*c*(1-d)*sb*i+(1-p)*np*(1-q)*nq*c*d*sf*i+(1-p)*np*(1-q)*nq*(1-c)*x*sfb*i+(1-p)*np*q*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*np*q*(1-nq)*c*d*sf*i+(1-p)*np*q*(1-nq)*c*d*sf*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*q*nq*c*d*sf*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*sb*i+p*(1-np)*(1-q)*nq*c*d*(1-sf)*i+p*(1-np)*(1-q)*nq*c*d*(1-sf)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*sb*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*i+p*(1-np)*q*(1-nq)*c*d*(1-sf)*i+p*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*i+p*(1-np)*q*nq*c*d*(1-sf)*i+p*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+p*np*(1-q)*(1-nq)*c*(1-d)*sb*i+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*(1-q)*nq*c*(1-d)*sb*i+p*np*q*(1-nq)*c*(1-d)*(1-sb)*i;
  theta[2] = (1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*(1-q)*nq*c*d*sf*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*q*nq*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*q*nq*c*d*sf*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-sb)*i+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*nq*c*d*sf*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-sb)*i+(1-p)*np*q*nq*c*d*sf*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*i+p*(1-np)*q*nq*c*(1-d)*(1-sb)*i+p*(1-np)*q*nq*(1-c)*x*(1-sfb)*i+p*np*(1-q)*nq*c*(1-d)*(1-sb)*i+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*(1-sb)*i;
  theta[3] = (1-p)*(1-np)*q*(1-nq)*c*(1-d)*sb*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*sfb*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*sb*i+(1-p)*(1-np)*q*nq*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*sfb*i+(1-p)*np*q*(1-nq)*c*(1-d)*sb*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*q*(1-nq)*(1-c)*x*sfb*i+(1-p)*np*q*nq*c*(1-d)*sb*i+(1-p)*np*q*nq*(1-c)*x*sfb*i+p*(1-np)*q*(1-nq)*c*(1-d)*sb*i+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*(1-nq)*c*d*(1-sf)*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*sb*(1-i)+p*(1-np)*q*nq*c*(1-d)*sb*i+p*(1-np)*q*nq*c*d*(1-sf)*(1-i)+p*(1-np)*q*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*(1-d)*sb*i+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*sb*i;
  theta[4] = (1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*nq*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*(1-c)*(1-x)*(1-d)*i;
  theta[5] = (1-p)*np*(1-q)*(1-nq)*c*d*(1-sf)*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*np*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*(1-q)*nq*c*d*(1-sf)*i+(1-p)*np*(1-q)*nq*c*d*(1-sf)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*sb*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*np*q*(1-nq)*c*d*(1-sf)*i+(1-p)*np*q*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*q*nq*c*d*(1-sf)*i+(1-p)*np*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*(1-sf)*i+p*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+p*np*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+p*np*(1-q)*nq*c*d*(1-sf)*i+p*np*(1-q)*nq*c*d*(1-sf)*(1-i)+p*np*(1-q)*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*d*(1-sf)*i+p*np*q*(1-nq)*(1-c)*x*(1-sfb)*i+p*np*q*nq*c*d*(1-sf)*i;
  theta[6] = (1-p)*np*(1-q)*nq*(1-c)*x*(1-sfb)*i+(1-p)*np*(1-q)*nq*(1-c)*x*sfb*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-sfb)*i+p*np*(1-q)*nq*(1-c)*x*(1-sfb)*i+p*np*q*nq*(1-c)*x*(1-sfb)*i;
  theta[7] = (1-p)*np*q*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*c*d*(1-sf)*(1-i)+(1-p)*np*q*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*d*(1-sf)*(1-i)+p*np*q*(1-nq)*c*(1-d)*sb*(1-i)+p*np*q*nq*c*d*(1-sf)*(1-i)+p*np*q*nq*c*(1-d)*sb*(1-i);
  theta[8] = (1-p)*np*q*nq*(1-c)*x*sfb*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i);
  theta[9] = p*(1-np)*(1-q)*(1-nq)*c*d*sf*i+p*(1-np)*(1-q)*(1-nq)*c*d*sf*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*(1-q)*nq*c*d*sf*i+p*(1-np)*(1-q)*nq*(1-c)*x*sfb*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+p*(1-np)*q*(1-nq)*c*d*sf*i+p*(1-np)*q*(1-nq)*c*d*sf*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*q*nq*c*d*sf*i+p*(1-np)*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*sf*i+p*np*(1-q)*(1-nq)*c*d*sf*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*sfb*i+p*np*(1-q)*nq*c*d*sf*i+p*np*(1-q)*nq*(1-c)*x*sfb*i+p*np*q*(1-nq)*c*d*sf*i+p*np*q*(1-nq)*c*d*sf*(1-i)+p*np*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*np*q*nq*c*d*sf*i;
  theta[10] = p*(1-np)*(1-q)*nq*c*d*sf*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*sfb*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*c*d*sf*(1-i)+p*(1-np)*q*nq*c*(1-d)*(1-sb)*(1-i)+p*np*(1-q)*nq*c*d*sf*(1-i)+p*np*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+p*np*q*nq*c*d*sf*(1-i)+p*np*q*nq*c*(1-d)*(1-sb)*(1-i);
  theta[11] = p*(1-np)*q*(1-nq)*(1-c)*x*sfb*i+p*(1-np)*q*(1-nq)*(1-c)*x*sfb*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*(1-c)*x*sfb*i+p*np*q*(1-nq)*(1-c)*x*sfb*i+p*np*q*nq*(1-c)*x*sfb*i;
  theta[12] = p*(1-np)*q*nq*(1-c)*x*sfb*(1-i)+p*(1-np)*q*nq*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i);
  theta[13] = p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*i+p*np*q*(1-nq)*(1-c)*(1-x)*d*i+p*np*q*nq*(1-c)*(1-x)*d*i;
  theta[14] = p*np*(1-q)*nq*(1-c)*x*sfb*(1-i)+p*np*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i);
  theta[15] = p*np*q*(1-nq)*(1-c)*x*sfb*(1-i)+p*np*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i);
  theta[16] = p*np*q*nq*(1-c)*x*sfb*(1-i)+p*np*q*nq*(1-c)*x*(1-sfb)*(1-i)+p*np*q*nq*(1-c)*(1-x)*d*(1-i)+p*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i);
}
model {
  // Priors
  target += beta_lpdf(p | 1, 1);
  target += beta_lpdf(np | 1, 1);
  target += beta_lpdf(q | 1, 1);
  target += beta_lpdf(nq | 1, 1);
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
