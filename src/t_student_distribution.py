from scipy.stats import t
from math import gamma


def calculate_expected_value(mean, std, dof, alpha, beta):

    a = (alpha - mean) / std
    b = (beta - mean) / std

    gamma_factor = gamma((dof - 1)/2)
    ab_factor = ((dof + (a**2))**(-(dof - 1)/2) - (dof + (b**2))**(-(dof - 1)/2))
    dof_factor = dof ** (dof / 2)
    cdf_factor = 2*(t.cdf(b, dof) - t.cdf(a, dof))

    EX = mean + std * (\
        (gamma_factor * ab_factor * dof_factor)\
        /(cdf_factor * gamma(dof/2) * gamma(1/2))
        )

    return EX