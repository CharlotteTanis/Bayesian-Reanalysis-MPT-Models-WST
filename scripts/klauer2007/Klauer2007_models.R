###############################################################################
# All specifications of Klauer's models in the form of the MPTinR package
###############################################################################

# Independence model ----------------------------------------------------------
independence <- "
(1 - p) * (1 - np) * (1 - q) * (1 - nq)  # 0000
(1 - p) * (1 - np) * (1 - q) * nq        # 0001
(1 - p) * (1 - np) * q * (1 - nq)        # 0010
(1 - p) * (1 - np) * q * nq              # 0011
(1 - p) * np * (1 - q) * (1 - nq)        # 0100
(1 - p) * np * (1 - q) * nq              # 0101
(1 - p) * np * q * (1 - nq)              # 0110
(1 - p) * np * q * nq                    # 0111
p * (1 - np) * (1 - q) * (1 - nq)        # 1000
p * (1 - np) * (1 - q) * nq              # 1001
p * (1 - np) * q * (1 - nq)              # 1010
p * (1 - np) * q * nq                    # 1011
p * np * (1 - q) * (1 - nq)              # 1100
p * np * (1 - q) * nq                    # 1101
p * np * q * (1 - nq)                    # 1110
p * np * q * nq                          # 1111
"

# Inference-guessing model ----------------------------------------------------
inferenceGuessing <- "
(1 - a) * (1 - p) * (1 - np) * (1 - q) * (1 - nq)  # 0000
a * c * (1 - d) * (1 - s) * i + (1 - a) * (1 - p) * (1 - np) * (1 - q) * nq        # 0001
a * c * (1 - d) * s * i + (1 - a) * (1 - p) * (1 - np) * q * (1 - nq)        # 0010
a * (1 - c) * (1 - x) * (1 - d) * i + (1 - a) * (1 - p) * (1 - np) * q * nq              # 0011
a * c * d * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * (1 - nq)        # 0100
a * (1 - c) * x * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * nq              # 0101
a * c * d * (1 - s) * (1 - i) + a * c * (1 - d) * s * (1 - i) + (1 - a) * (1 - p) * np * q * (1 - nq)              # 0110
(1 - a) * (1 - p) * np * q * nq                    # 0111
a * c * d * s * i + (1 - a) * p * (1 - np) * (1 - q) * (1 - nq)        # 1000
a * c * d * s * (1 - i) + a * c * (1 - d) * (1 - s) * (1 - i) + (1 - a) * p * (1 - np) * (1 - q) * nq              # 1001
a * (1 - c) * x * s * i + (1 - a) * p * (1 - np) * q * (1 - nq)              # 1010
(1 - a) * p * (1 - np) * q * nq                    # 1011
a * (1 - c) * (1 - x) * d * i + (1 - a) * p * np * (1 - q) * (1 - nq)              # 1100
(1 - a) * p * np * (1 - q) * nq                    # 1101
(1 - a) * p * np * q * (1 - nq)                    # 1110
a * (1 - c) * x * s * (1 - i) + a * (1 - c) * x * (1 - s) * (1 - i) + a * (1 - c) * (1 - x) * d * (1 - i) + a * (1 - c) * (1 - x) * (1 - d) * (1 - i) + (1 - a) * p * np * q * nq                          # 1111
"

# Inference-guessing model, relaxed version -----------------------------------
# Copy paste inference-guessing model and set s parameters to sf, sb, and sfb
inferenceGuessingRel <- "
(1 - a) * (1 - p) * (1 - np) * (1 - q) * (1 - nq)  # 0000
a * c * (1 - d) * (1 - sb) * i + (1 - a) * (1 - p) * (1 - np) * (1 - q) * nq        # 0001
a * c * (1 - d) * sb * i + (1 - a) * (1 - p) * (1 - np) * q * (1 - nq)        # 0010
a * (1 - c) * (1 - x) * (1 - d) * i + (1 - a) * (1 - p) * (1 - np) * q * nq              # 0011
a * c * d * (1 - sf) * i + (1 - a) * (1 - p) * np * (1 - q) * (1 - nq)        # 0100
a * (1 - c) * x * (1 - sfb) * i + (1 - a) * (1 - p) * np * (1 - q) * nq              # 0101
a * c * d * (1 - sf) * (1 - i) + a * c * (1 - d) * sb * (1 - i) + (1 - a) * (1 - p) * np * q * (1 - nq)              # 0110
(1 - a) * (1 - p) * np * q * nq                    # 0111
a * c * d * sf * i + (1 - a) * p * (1 - np) * (1 - q) * (1 - nq)        # 1000
a * c * d * sf * (1 - i) + a * c * (1 - d) * (1 - sb) * (1 - i) + (1 - a) * p * (1 - np) * (1 - q) * nq              # 1001
a * (1 - c) * x * sfb * i + (1 - a) * p * (1 - np) * q * (1 - nq)              # 1010
(1 - a) * p * (1 - np) * q * nq                    # 1011
a * (1 - c) * (1 - x) * d * i + (1 - a) * p * np * (1 - q) * (1 - nq)              # 1100
(1 - a) * p * np * (1 - q) * nq                    # 1101
(1 - a) * p * np * q * (1 - nq)                    # 1110
a * (1 - c) * x * sfb * (1 - i) + a * (1 - c) * x * (1 - sfb) * (1 - i) + a * (1 - c) * (1 - x) * d * (1 - i) + a * (1 - c) * (1 - x) * (1 - d) * (1 - i) + (1 - a) * p * np * q * nq                          # 1111
"

# Heuristic-analytic model - see constructing_heuristic-analytic-model.R ------
heuristicAnalytic <- "
(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*s*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*d*s*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*s*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*c*d*s*i+(1-p)*(1-np)*q*(1-nq)*c*d*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*nq*c*d*(1-s)*i+(1-p)*(1-np)*q*nq*c*d*s*i+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*s*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*(1-nq)*c*d*s*i+(1-p)*np*(1-q)*(1-nq)*c*d*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*s*i+(1-p)*np*(1-q)*nq*c*(1-d)*s*i+(1-p)*np*(1-q)*nq*c*d*s*i+(1-p)*np*(1-q)*nq*(1-c)*x*s*i+(1-p)*np*q*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*np*q*(1-nq)*c*d*s*i+(1-p)*np*q*(1-nq)*c*d*s*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*np*q*nq*c*d*s*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*s*i+p*(1-np)*(1-q)*nq*c*d*(1-s)*i+p*(1-np)*(1-q)*nq*c*d*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*s*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*i+p*(1-np)*q*(1-nq)*c*d*(1-s)*i+p*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*i+p*(1-np)*q*nq*c*d*(1-s)*i+p*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+p*np*(1-q)*(1-nq)*c*(1-d)*s*i+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*(1-q)*nq*c*(1-d)*s*i+p*np*q*(1-nq)*c*(1-d)*(1-s)*i
(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*c*d*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-s)*i+(1-p)*(1-np)*q*nq*(1-c)*x*(1-s)*i+(1-p)*(1-np)*q*nq*c*d*s*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-s)*i+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*nq*c*d*s*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-s)*i+(1-p)*np*q*nq*c*d*s*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*i+p*(1-np)*q*nq*c*(1-d)*(1-s)*i+p*(1-np)*q*nq*(1-c)*x*(1-s)*i+p*np*(1-q)*nq*c*(1-d)*(1-s)*i+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*(1-s)*i
(1-p)*(1-np)*q*(1-nq)*c*(1-d)*s*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*s*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*s*i+(1-p)*(1-np)*q*nq*c*d*(1-s)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*s*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*s*i+(1-p)*np*q*(1-nq)*c*(1-d)*s*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*q*(1-nq)*(1-c)*x*s*i+(1-p)*np*q*nq*c*(1-d)*s*i+(1-p)*np*q*nq*(1-c)*x*s*i+p*(1-np)*q*(1-nq)*c*(1-d)*s*i+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*(1-nq)*c*d*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*s*(1-i)+p*(1-np)*q*nq*c*(1-d)*s*i+p*(1-np)*q*nq*c*d*(1-s)*(1-i)+p*(1-np)*q*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*(1-d)*s*i+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*s*i
(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*nq*(1-c)*x*s*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*(1-c)*(1-x)*(1-d)*i
(1-p)*np*(1-q)*(1-nq)*c*d*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*(1-q)*nq*c*d*(1-s)*i+(1-p)*np*(1-q)*nq*c*d*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*s*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*np*q*(1-nq)*c*d*(1-s)*i+(1-p)*np*q*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*q*nq*c*d*(1-s)*i+(1-p)*np*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*(1-s)*i+p*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+p*np*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+p*np*(1-q)*nq*c*d*(1-s)*i+p*np*(1-q)*nq*c*d*(1-s)*(1-i)+p*np*(1-q)*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*d*(1-s)*i+p*np*q*(1-nq)*(1-c)*x*(1-s)*i+p*np*q*nq*c*d*(1-s)*i
(1-p)*np*(1-q)*nq*(1-c)*x*(1-s)*i+(1-p)*np*(1-q)*nq*(1-c)*x*s*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-s)*i+p*np*(1-q)*nq*(1-c)*x*(1-s)*i+p*np*q*nq*(1-c)*x*(1-s)*i
(1-p)*np*q*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*c*d*(1-s)*(1-i)+(1-p)*np*q*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*d*(1-s)*(1-i)+p*np*q*(1-nq)*c*(1-d)*s*(1-i)+p*np*q*nq*c*d*(1-s)*(1-i)+p*np*q*nq*c*(1-d)*s*(1-i)
(1-p)*np*q*nq*(1-c)*x*s*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*(1-np)*(1-q)*(1-nq)*c*d*s*i+p*(1-np)*(1-q)*(1-nq)*c*d*s*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*(1-q)*nq*c*d*s*i+p*(1-np)*(1-q)*nq*(1-c)*x*s*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+p*(1-np)*q*(1-nq)*c*d*s*i+p*(1-np)*q*(1-nq)*c*d*s*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*q*nq*c*d*s*i+p*(1-np)*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*s*i+p*np*(1-q)*(1-nq)*c*d*s*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*s*i+p*np*(1-q)*nq*c*d*s*i+p*np*(1-q)*nq*(1-c)*x*s*i+p*np*q*(1-nq)*c*d*s*i+p*np*q*(1-nq)*c*d*s*(1-i)+p*np*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*np*q*nq*c*d*s*i
p*(1-np)*(1-q)*nq*c*d*s*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*s*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*c*d*s*(1-i)+p*(1-np)*q*nq*c*(1-d)*(1-s)*(1-i)+p*np*(1-q)*nq*c*d*s*(1-i)+p*np*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+p*np*q*nq*c*d*s*(1-i)+p*np*q*nq*c*(1-d)*(1-s)*(1-i)
p*(1-np)*q*(1-nq)*(1-c)*x*s*i+p*(1-np)*q*(1-nq)*(1-c)*x*s*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*(1-c)*x*s*i+p*np*q*(1-nq)*(1-c)*x*s*i+p*np*q*nq*(1-c)*x*s*i
p*(1-np)*q*nq*(1-c)*x*s*(1-i)+p*(1-np)*q*nq*(1-c)*x*(1-s)*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*i+p*np*q*(1-nq)*(1-c)*(1-x)*d*i+p*np*q*nq*(1-c)*(1-x)*d*i
p*np*(1-q)*nq*(1-c)*x*s*(1-i)+p*np*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*(1-nq)*(1-c)*x*s*(1-i)+p*np*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*nq*(1-c)*x*s*(1-i)+p*np*q*nq*(1-c)*x*(1-s)*(1-i)+p*np*q*nq*(1-c)*(1-x)*d*(1-i)+p*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
"

# Heuristic-analytic model, relaxed version -----------------------------------
heuristicAnalyticRel <- "
(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*sf*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*sf*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*sb*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-sf)*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*d*sf*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*sfb*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-sf)*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*q*(1-nq)*c*d*sf*i+(1-p)*(1-np)*q*(1-nq)*c*d*sf*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*nq*c*d*(1-sf)*i+(1-p)*(1-np)*q*nq*c*d*sf*i+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*sb*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*(1-nq)*c*d*sf*i+(1-p)*np*(1-q)*(1-nq)*c*d*sf*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*sfb*i+(1-p)*np*(1-q)*nq*c*(1-d)*sb*i+(1-p)*np*(1-q)*nq*c*d*sf*i+(1-p)*np*(1-q)*nq*(1-c)*x*sfb*i+(1-p)*np*q*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*np*q*(1-nq)*c*d*sf*i+(1-p)*np*q*(1-nq)*c*d*sf*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*q*nq*c*d*sf*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*sb*i+p*(1-np)*(1-q)*nq*c*d*(1-sf)*i+p*(1-np)*(1-q)*nq*c*d*(1-sf)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*sb*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*i+p*(1-np)*q*(1-nq)*c*d*(1-sf)*i+p*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*i+p*(1-np)*q*nq*c*d*(1-sf)*i+p*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+p*np*(1-q)*(1-nq)*c*(1-d)*sb*i+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*(1-q)*nq*c*(1-d)*sb*i+p*np*q*(1-nq)*c*(1-d)*(1-sb)*i
(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*(1-q)*nq*c*d*sf*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*q*nq*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*q*nq*c*d*sf*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-sb)*i+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*nq*c*d*sf*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-sb)*i+(1-p)*np*q*nq*c*d*sf*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*i+p*(1-np)*q*nq*c*(1-d)*(1-sb)*i+p*(1-np)*q*nq*(1-c)*x*(1-sfb)*i+p*np*(1-q)*nq*c*(1-d)*(1-sb)*i+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*(1-sb)*i
(1-p)*(1-np)*q*(1-nq)*c*(1-d)*sb*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*sfb*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*sb*i+(1-p)*(1-np)*q*nq*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*sfb*i+(1-p)*np*q*(1-nq)*c*(1-d)*sb*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*q*(1-nq)*(1-c)*x*sfb*i+(1-p)*np*q*nq*c*(1-d)*sb*i+(1-p)*np*q*nq*(1-c)*x*sfb*i+p*(1-np)*q*(1-nq)*c*(1-d)*sb*i+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*(1-nq)*c*d*(1-sf)*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*sb*(1-i)+p*(1-np)*q*nq*c*(1-d)*sb*i+p*(1-np)*q*nq*c*d*(1-sf)*(1-i)+p*(1-np)*q*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*(1-d)*sb*i+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*sb*i
(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*nq*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*(1-c)*(1-x)*(1-d)*i
(1-p)*np*(1-q)*(1-nq)*c*d*(1-sf)*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*np*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*(1-q)*nq*c*d*(1-sf)*i+(1-p)*np*(1-q)*nq*c*d*(1-sf)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*sb*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*np*q*(1-nq)*c*d*(1-sf)*i+(1-p)*np*q*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*q*nq*c*d*(1-sf)*i+(1-p)*np*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*(1-sf)*i+p*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+p*np*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+p*np*(1-q)*nq*c*d*(1-sf)*i+p*np*(1-q)*nq*c*d*(1-sf)*(1-i)+p*np*(1-q)*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*d*(1-sf)*i+p*np*q*(1-nq)*(1-c)*x*(1-sfb)*i+p*np*q*nq*c*d*(1-sf)*i
(1-p)*np*(1-q)*nq*(1-c)*x*(1-sfb)*i+(1-p)*np*(1-q)*nq*(1-c)*x*sfb*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-sfb)*i+p*np*(1-q)*nq*(1-c)*x*(1-sfb)*i+p*np*q*nq*(1-c)*x*(1-sfb)*i
(1-p)*np*q*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*c*d*(1-sf)*(1-i)+(1-p)*np*q*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*d*(1-sf)*(1-i)+p*np*q*(1-nq)*c*(1-d)*sb*(1-i)+p*np*q*nq*c*d*(1-sf)*(1-i)+p*np*q*nq*c*(1-d)*sb*(1-i)
(1-p)*np*q*nq*(1-c)*x*sfb*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*(1-np)*(1-q)*(1-nq)*c*d*sf*i+p*(1-np)*(1-q)*(1-nq)*c*d*sf*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*(1-q)*nq*c*d*sf*i+p*(1-np)*(1-q)*nq*(1-c)*x*sfb*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+p*(1-np)*q*(1-nq)*c*d*sf*i+p*(1-np)*q*(1-nq)*c*d*sf*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*q*nq*c*d*sf*i+p*(1-np)*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*sf*i+p*np*(1-q)*(1-nq)*c*d*sf*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*sfb*i+p*np*(1-q)*nq*c*d*sf*i+p*np*(1-q)*nq*(1-c)*x*sfb*i+p*np*q*(1-nq)*c*d*sf*i+p*np*q*(1-nq)*c*d*sf*(1-i)+p*np*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*np*q*nq*c*d*sf*i
p*(1-np)*(1-q)*nq*c*d*sf*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*sfb*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*c*d*sf*(1-i)+p*(1-np)*q*nq*c*(1-d)*(1-sb)*(1-i)+p*np*(1-q)*nq*c*d*sf*(1-i)+p*np*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+p*np*q*nq*c*d*sf*(1-i)+p*np*q*nq*c*(1-d)*(1-sb)*(1-i)
p*(1-np)*q*(1-nq)*(1-c)*x*sfb*i+p*(1-np)*q*(1-nq)*(1-c)*x*sfb*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*(1-c)*x*sfb*i+p*np*q*(1-nq)*(1-c)*x*sfb*i+p*np*q*nq*(1-c)*x*sfb*i
p*(1-np)*q*nq*(1-c)*x*sfb*(1-i)+p*(1-np)*q*nq*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*i+p*np*q*(1-nq)*(1-c)*(1-x)*d*i+p*np*q*nq*(1-c)*(1-x)*d*i
p*np*(1-q)*nq*(1-c)*x*sfb*(1-i)+p*np*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*(1-nq)*(1-c)*x*sfb*(1-i)+p*np*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*nq*(1-c)*x*sfb*(1-i)+p*np*q*nq*(1-c)*x*(1-sfb)*(1-i)+p*np*q*nq*(1-c)*(1-x)*d*(1-i)+p*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
"

# Inference-guessing model, two groups combined -------------------------------
inferenceGuessingTwoGroups <- "
(1 - a) * (1 - p) * (1 - np) * (1 - q) * (1 - nq)  # 0000
a * c * (1 - d) * (1 - s) * i + (1 - a) * (1 - p) * (1 - np) * (1 - q) * nq        # 0001
a * c * (1 - d) * s * i + (1 - a) * (1 - p) * (1 - np) * q * (1 - nq)        # 0010
a * (1 - c) * (1 - x) * (1 - d) * i + (1 - a) * (1 - p) * (1 - np) * q * nq              # 0011
a * c * d * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * (1 - nq)        # 0100
a * (1 - c) * x * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * nq              # 0101
a * c * d * (1 - s) * (1 - i) + a * c * (1 - d) * s * (1 - i) + (1 - a) * (1 - p) * np * q * (1 - nq)              # 0110
(1 - a) * (1 - p) * np * q * nq                    # 0111
a * c * d * s * i + (1 - a) * p * (1 - np) * (1 - q) * (1 - nq)        # 1000
a * c * d * s * (1 - i) + a * c * (1 - d) * (1 - s) * (1 - i) + (1 - a) * p * (1 - np) * (1 - q) * nq              # 1001
a * (1 - c) * x * s * i + (1 - a) * p * (1 - np) * q * (1 - nq)              # 1010
(1 - a) * p * (1 - np) * q * nq                    # 1011
a * (1 - c) * (1 - x) * d * i + (1 - a) * p * np * (1 - q) * (1 - nq)              # 1100
(1 - a) * p * np * (1 - q) * nq                    # 1101
(1 - a) * p * np * q * (1 - nq)                    # 1110
a * (1 - c) * x * s * (1 - i) + a * (1 - c) * x * (1 - s) * (1 - i) + a * (1 - c) * (1 - x) * d * (1 - i) + a * (1 - c) * (1 - x) * (1 - d) * (1 - i) + (1 - a) * p * np * q * nq                          # 1111

(1 - a2) * (1 - p2) * (1 - np2) * (1 - q2) * (1 - nq2)  # 0000
a2 * c2 * (1 - d2) * (1 - s2) * i2 + (1 - a2) * (1 - p2) * (1 - np2) * (1 - q2) * nq2        # 0001
a2 * c2 * (1 - d2) * s2 * i2 + (1 - a2) * (1 - p2) * (1 - np2) * q2 * (1 - nq2)        # 0010
a2 * (1 - c2) * (1 - x2) * (1 - d2) * i2 + (1 - a2) * (1 - p2) * (1 - np2) * q2 * nq2              # 0011
a2 * c2 * d2 * (1 - s2) * i2 + (1 - a2) * (1 - p2) * np2 * (1 - q2) * (1 - nq2)        # 0100
a2 * (1 - c2) * x2 * (1 - s2) * i2 + (1 - a2) * (1 - p2) * np2 * (1 - q2) * nq2              # 0101
a2 * c2 * d2 * (1 - s2) * (1 - i2) + a2 * c2 * (1 - d2) * s2 * (1 - i2) + (1 - a2) * (1 - p2) * np2 * q2 * (1 - nq2)              # 0110
(1 - a2) * (1 - p2) * np2 * q2 * nq2                    # 0111
a2 * c2 * d2 * s2 * i2 + (1 - a2) * p2 * (1 - np2) * (1 - q2) * (1 - nq2)        # 1000
a2 * c2 * d2 * s2 * (1 - i2) + a2 * c2 * (1 - d2) * (1 - s2) * (1 - i2) + (1 - a2) * p2 * (1 - np2) * (1 - q2) * nq2              # 1001
a2 * (1 - c2) * x2 * s2 * i2 + (1 - a2) * p2 * (1 - np2) * q2 * (1 - nq2)              # 1010
(1 - a2) * p2 * (1 - np2) * q2 * nq2                    # 1011
a2 * (1 - c2) * (1 - x2) * d2 * i2 + (1 - a2) * p2 * np2 * (1 - q2) * (1 - nq2)              # 1100
(1 - a2) * p2 * np2 * (1 - q2) * nq2                    # 1101
(1 - a2) * p2 * np2 * q2 * (1 - nq2)                    # 1110
a2 * (1 - c2) * x2 * s2 * (1 - i2) + a2 * (1 - c2) * x2 * (1 - s2) * (1 - i2) + a2 * (1 - c2) * (1 - x2) * d2 * (1 - i2) + a2 * (1 - c2) * (1 - x2) * (1 - d2) * (1 - i2) + (1 - a2) * p2 * np2 * q2 * nq2                          # 1111
"

# Inference-guessing model four groups combined -------------------------------
inferenceGuessingFourGroups <- "
(1 - a) * (1 - p) * (1 - np) * (1 - q) * (1 - nq)  # 0000
a * c * (1 - d) * (1 - s) * i + (1 - a) * (1 - p) * (1 - np) * (1 - q) * nq        # 0001
a * c * (1 - d) * s * i + (1 - a) * (1 - p) * (1 - np) * q * (1 - nq)        # 0010
a * (1 - c) * (1 - x) * (1 - d) * i + (1 - a) * (1 - p) * (1 - np) * q * nq              # 0011
a * c * d * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * (1 - nq)        # 0100
a * (1 - c) * x * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * nq              # 0101
a * c * d * (1 - s) * (1 - i) + a * c * (1 - d) * s * (1 - i) + (1 - a) * (1 - p) * np * q * (1 - nq)              # 0110
(1 - a) * (1 - p) * np * q * nq                    # 0111
a * c * d * s * i + (1 - a) * p * (1 - np) * (1 - q) * (1 - nq)        # 1000
a * c * d * s * (1 - i) + a * c * (1 - d) * (1 - s) * (1 - i) + (1 - a) * p * (1 - np) * (1 - q) * nq              # 1001
a * (1 - c) * x * s * i + (1 - a) * p * (1 - np) * q * (1 - nq)              # 1010
(1 - a) * p * (1 - np) * q * nq                    # 1011
a * (1 - c) * (1 - x) * d * i + (1 - a) * p * np * (1 - q) * (1 - nq)              # 1100
(1 - a) * p * np * (1 - q) * nq                    # 1101
(1 - a) * p * np * q * (1 - nq)                    # 1110
a * (1 - c) * x * s * (1 - i) + a * (1 - c) * x * (1 - s) * (1 - i) + a * (1 - c) * (1 - x) * d * (1 - i) + a * (1 - c) * (1 - x) * (1 - d) * (1 - i) + (1 - a) * p * np * q * nq                          # 1111

(1 - a2) * (1 - p2) * (1 - np2) * (1 - q2) * (1 - nq2)  # 0000
a2 * c2 * (1 - d2) * (1 - s2) * i2 + (1 - a2) * (1 - p2) * (1 - np2) * (1 - q2) * nq2        # 0001
a2 * c2 * (1 - d2) * s2 * i2 + (1 - a2) * (1 - p2) * (1 - np2) * q2 * (1 - nq2)        # 0010
a2 * (1 - c2) * (1 - x2) * (1 - d2) * i2 + (1 - a2) * (1 - p2) * (1 - np2) * q2 * nq2              # 0011
a2 * c2 * d2 * (1 - s2) * i2 + (1 - a2) * (1 - p2) * np2 * (1 - q2) * (1 - nq2)        # 0100
a2 * (1 - c2) * x2 * (1 - s2) * i2 + (1 - a2) * (1 - p2) * np2 * (1 - q2) * nq2              # 0101
a2 * c2 * d2 * (1 - s2) * (1 - i2) + a2 * c2 * (1 - d2) * s2 * (1 - i2) + (1 - a2) * (1 - p2) * np2 * q2 * (1 - nq2)              # 0110
(1 - a2) * (1 - p2) * np2 * q2 * nq2                    # 0111
a2 * c2 * d2 * s2 * i2 + (1 - a2) * p2 * (1 - np2) * (1 - q2) * (1 - nq2)        # 1000
a2 * c2 * d2 * s2 * (1 - i2) + a2 * c2 * (1 - d2) * (1 - s2) * (1 - i2) + (1 - a2) * p2 * (1 - np2) * (1 - q2) * nq2              # 1001
a2 * (1 - c2) * x2 * s2 * i2 + (1 - a2) * p2 * (1 - np2) * q2 * (1 - nq2)              # 1010
(1 - a2) * p2 * (1 - np2) * q2 * nq2                    # 1011
a2 * (1 - c2) * (1 - x2) * d2 * i2 + (1 - a2) * p2 * np2 * (1 - q2) * (1 - nq2)              # 1100
(1 - a2) * p2 * np2 * (1 - q2) * nq2                    # 1101
(1 - a2) * p2 * np2 * q2 * (1 - nq2)                    # 1110
a2 * (1 - c2) * x2 * s2 * (1 - i2) + a2 * (1 - c2) * x2 * (1 - s2) * (1 - i2) + a2 * (1 - c2) * (1 - x2) * d2 * (1 - i2) + a2 * (1 - c2) * (1 - x2) * (1 - d2) * (1 - i2) + (1 - a2) * p2 * np2 * q2 * nq2                          # 1111

(1 - a3) * (1 - p3) * (1 - np3) * (1 - q3) * (1 - nq3)  # 0000
a3 * c3 * (1 - d3) * (1 - s3) * i3 + (1 - a3) * (1 - p3) * (1 - np3) * (1 - q3) * nq3        # 0001
a3 * c3 * (1 - d3) * s3 * i3 + (1 - a3) * (1 - p3) * (1 - np3) * q3 * (1 - nq3)        # 0010
a3 * (1 - c3) * (1 - x3) * (1 - d3) * i3 + (1 - a3) * (1 - p3) * (1 - np3) * q3 * nq3              # 0011
a3 * c3 * d3 * (1 - s3) * i3 + (1 - a3) * (1 - p3) * np3 * (1 - q3) * (1 - nq3)        # 0100
a3 * (1 - c3) * x3 * (1 - s3) * i3 + (1 - a3) * (1 - p3) * np3 * (1 - q3) * nq3              # 0101
a3 * c3 * d3 * (1 - s3) * (1 - i3) + a3 * c3 * (1 - d3) * s3 * (1 - i3) + (1 - a3) * (1 - p3) * np3 * q3 * (1 - nq3)              # 0110
(1 - a3) * (1 - p3) * np3 * q3 * nq3                    # 0111
a3 * c3 * d3 * s3 * i3 + (1 - a3) * p3 * (1 - np3) * (1 - q3) * (1 - nq3)        # 1000
a3 * c3 * d3 * s3 * (1 - i3) + a3 * c3 * (1 - d3) * (1 - s3) * (1 - i3) + (1 - a3) * p3 * (1 - np3) * (1 - q3) * nq3              # 1001
a3 * (1 - c3) * x3 * s3 * i3 + (1 - a3) * p3 * (1 - np3) * q3 * (1 - nq3)              # 1010
(1 - a3) * p3 * (1 - np3) * q3 * nq3                    # 1011
a3 * (1 - c3) * (1 - x3) * d3 * i3 + (1 - a3) * p3 * np3 * (1 - q3) * (1 - nq3)              # 1100
(1 - a3) * p3 * np3 * (1 - q3) * nq3                    # 1101
(1 - a3) * p3 * np3 * q3 * (1 - nq3)                    # 1110
a3 * (1 - c3) * x3 * s3 * (1 - i3) + a3 * (1 - c3) * x3 * (1 - s3) * (1 - i3) + a3 * (1 - c3) * (1 - x3) * d3 * (1 - i3) + a3 * (1 - c3) * (1 - x3) * (1 - d3) * (1 - i3) + (1 - a3) * p3 * np3 * q3 * nq3                          # 1111

(1 - a4) * (1 - p4) * (1 - np4) * (1 - q4) * (1 - nq4)  # 0000
a4 * c4 * (1 - d4) * (1 - s4) * i4 + (1 - a4) * (1 - p4) * (1 - np4) * (1 - q4) * nq4        # 0001
a4 * c4 * (1 - d4) * s4 * i4 + (1 - a4) * (1 - p4) * (1 - np4) * q4 * (1 - nq4)        # 0010
a4 * (1 - c4) * (1 - x4) * (1 - d4) * i4 + (1 - a4) * (1 - p4) * (1 - np4) * q4 * nq4              # 0011
a4 * c4 * d4 * (1 - s4) * i4 + (1 - a4) * (1 - p4) * np4 * (1 - q4) * (1 - nq4)        # 0100
a4 * (1 - c4) * x4 * (1 - s4) * i4 + (1 - a4) * (1 - p4) * np4 * (1 - q4) * nq4              # 0101
a4 * c4 * d4 * (1 - s4) * (1 - i4) + a4 * c4 * (1 - d4) * s4 * (1 - i4) + (1 - a4) * (1 - p4) * np4 * q4 * (1 - nq4)              # 0110
(1 - a4) * (1 - p4) * np4 * q4 * nq4                    # 0111
a4 * c4 * d4 * s4 * i4 + (1 - a4) * p4 * (1 - np4) * (1 - q4) * (1 - nq4)        # 1000
a4 * c4 * d4 * s4 * (1 - i4) + a4 * c4 * (1 - d4) * (1 - s4) * (1 - i4) + (1 - a4) * p4 * (1 - np4) * (1 - q4) * nq4              # 1001
a4 * (1 - c4) * x4 * s4 * i4 + (1 - a4) * p4 * (1 - np4) * q4 * (1 - nq4)              # 1010
(1 - a4) * p4 * (1 - np4) * q4 * nq4                    # 1011
a4 * (1 - c4) * (1 - x4) * d4 * i4 + (1 - a4) * p4 * np4 * (1 - q4) * (1 - nq4)              # 1100
(1 - a4) * p4 * np4 * (1 - q4) * nq4                    # 1101
(1 - a4) * p4 * np4 * q4 * (1 - nq4)                    # 1110
a4 * (1 - c4) * x4 * s4 * (1 - i4) + a4 * (1 - c4) * x4 * (1 - s4) * (1 - i4) + a4 * (1 - c4) * (1 - x4) * d4 * (1 - i4) + a4 * (1 - c4) * (1 - x4) * (1 - d4) * (1 - i4) + (1 - a4) * p4 * np4 * q4 * nq4                          # 1111
"

# Combine all models in a list ------------------------------------------------
# Relevance inference-guessing model is in seperate file - lines were too long
modelsKlauer <- list(independence = independence,
                     inferenceGuessing = inferenceGuessing,
                     inferenceGuessingRel = inferenceGuessingRel,
                     heuristicAnalytic = heuristicAnalytic,
                     heuristicAnalyticRel = heuristicAnalyticRel,
                     inferenceGuessingTwoGroups = inferenceGuessingTwoGroups,
                     inferenceGuessingFourGroups = inferenceGuessingFourGroups,
                     relevanceInferenceGuessing = "relevance-inference-guessing-model.txt"
                     )

