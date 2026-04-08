---
layout: post
title: "An overview of the Singular Value Decomposition"
---

A brief overview of the singular value decomposition (SVD), from my study notes.

## Definition

The SVD of any matrix $A$ with dimensions $m \times n$ and rank $r$ can be expressed as:

$$
A = U \Sigma V^*
$$

Or $A = U\Sigma V^T$ for real-valued matrices. We will focus here on the real-valued case.

Where:

- $U$ is the matrix of orthonormal eigenvectors of $AA^T$, known as the left singular vectors
- $V$ is the matrix of orthonormal eigenvectors of $A^TA$, known as the right singular vectors
- $\Sigma$ is a diagonal matrix with exactly $r$ non-zero singular values, which are the non-negative square roots of the eigenvalues of $AA^T$ and $A^TA$

This is more general than the eigendecomposition $A = Q\Lambda Q^{-1}$ which only applies to a square $n \times n$ matrix with $n$ linearly independent eigenvectors.

The SVD can be expressed in either full or reduced form. In the full form, the matrices have the following dimensions:

- $U$ is $m \times m$
- $\Sigma$ is $m \times n$ with all other entries besides the diagonal singular values as 0
- $V$ is $n \times n$

In the reduced form, rows and columns that are multiplied by zero are removed, which does not affect the result.

- If $m > n$ then $U$ is $m \times n$ and $\Sigma$ is $n \times n$
- If $n > m$ then $\Sigma$ is $m \times m$ and $V$ is $n \times m$

## Proof

Both $A^TA$ and $AA^T$ are symmetric matrices which means that they have real eigenvalues (if $A$ is real) and are diagonalisable. They are also positive semidefinite, which means that the eigenvalues are non-negative.

For any eigenvalue $\lambda$ of $A^TA$ with corresponding eigenvector $v$:

$$
(A^TA)v = \lambda v \\
\implies A(A^TA)v = A (\lambda v) \\
\implies (AA^T)Av = \lambda (Av)
$$

Which shows that $\lambda$ is also an eigenvalue of $AA^T$ with corresponding eigenvector $u = Av$. The length of the vector $u$ is $\sqrt{(Av)^T(Av)} = \sqrt{\lambda}$, so for a normalised eigenvector we would instead use $u = \frac{Av}{\sqrt{\lambda}}$, so that $\sqrt{\lambda}u = Av$.

Denote $\lambda = \sigma^2$ and $\Lambda = \Sigma^2$ (the diagonal eigenvalue matrix),  then using the orthonormal eigenvector matrices $U$ and $V$ we have:

$$
AV  = U \Sigma \\
\implies A = U \Sigma V^T
$$

## Intuition

A $m \times n$ matrix is a change of basis which can be applied to a vector of length $n$. Through matrix multiplication, the vector is expressed in terms of the new basis defined by the columns of the matrix. This change of basis occurs through rotation, reflection and scaling of the standard basis vectors.

The SVD decomposes the change of basis into three sequential steps:

1. Rotation and/or reflection via $V^T$
2. Scaling via the singular values
3. Another rotation and/or reflection via $U$

In other words, a matrix brings a vector into a coordinate system where it can scale each axis by a constant factor, then sends it back out again in a potentially different direction.

The rank $r$ and the four fundamental subspaces of $A$ define how these transformations take place.

- The first $r$ column vectors of $U$ span the column space $C(A)$ while the remaining $m-r$ columns span the left nullspace $N(A^T)$.
- The first $r$ columns of $V$ span the row space $C(A^T)$ while the remaining $n-r$ columns span the nullspace $N(A)$.

The change of basis accomplished by $A$ can be seen as squashing the basis vectors in the nullspace to zero, rotating/reflecting the basis vectors in the row space and then scaling them, and then rotating/reflecting them again into the column space. The left nullspace is the part of $\R^m$ that cannot be reached by the transformation $A$.

When the singular values and their corresponding singular vectors are ranked by magnitude, then the SVD provides an easy way to approximate the matrix $A$ in a lower dimensional form. This is done by truncating the singular values and singular vectors to only include the top $k$ (depending on the chosen rank of the approximation). According to the Eckart-Young theorem it is the optimal rank-$k$ approximation as measured by the Frobenius norm. Intuitively, this is a choice to compress $A$ into a subspace where it scales the basis vectors by the largest magnitude. Basis vectors that are shrunk by small singular values are ignored and grouped together with the nullspace.

## Pseudoinverse

Let $\Sigma^+$ be a $n \times m$ matrix that is the transpose of $\Sigma$ with reciprocals of each non-zero singular value. Then denote the pseudoinverse as the $n \times m$ matrix $A^+ = V \Sigma^+ U^T$, which has the easily verified properties:

$$
AA^+A = A \\
A^+AA^+ = A^+ \\
$$

In addition, $AA^+$ and $A^+A$ are Hermitian.

This provides a generalisation of the inverse for all $m \times n$ matrices, where $AA^+$ is a projection matrix onto the column space of $A$ and so acts as an identity matrix to $A$.

This is particularly applicable in linear regression, when trying to solve $X\beta = y$ without necessarily having a closed form solution $\hat{\beta} = X^{-1}y$. Instead, $\hat{\beta} = X^+ y$ can be used for any shape and rank of the data matrix $X$. Linear regression projects the target vector onto the column space of the data matrix, so that predictions $\hat{y} = XX^+y$ use the projection matrix $XX^+$.

## Principal component analysis

PCA is the eigendecomposition of a covariance matrix (which is symmetric) into the form $C = Q\Lambda Q^{-1}$ where the orthogonal eigenvectors are the principal components defining the directions of maximum variation in the data, and the eigenvalues define the magnitude of the variance.

After the data matrix $X$ is first centred, a covariance matrix is of the form $C = \frac{1}{n-1}X^TX$.

Using the SVD we have:

$$
X^TX = (U\Sigma V^T)^T U\Sigma V^T \\
= V \Sigma^T U^T U\Sigma V^T \\
= V\Sigma^2 V^T
$$

This is now in the form $C = Q\Lambda Q^{-1}$, indicating that $X^TX$ does not have to be explicitly calculated and that we can instead derive the principal components from the SVD of $X$ using the right singular vectors $V$, and the variances from $\frac{\sigma^2_i}{n-1}$.

## References

*Data Driven Science and Engineering* by Brunton and Kutz

*Differential Equations and Linear Algebra* by Strang

*Linear Algebra and its Applications* by Strang