# Code using one width for predicate and different width for masked
# compute.
#  int8_t a[]; int32_t b[], c[];
#  for (i=0; i<n; i++) { b[i] = (a[i] < 5) ? c[i] : 1; }
#
# Mixed-width code that keeps SEW/LMUL=8
loop:
	vsetvli a4, a0, e8,m1 	# Byte vector for predicate calc
	vlb.v v1, (a1) 		# Load a[i]
	add a1, a1, a4 		# Bump pointer.
	vmslt.vi v0, v1, 5 	# a[i] < 5?
	vsetvli x0, a0, e32,m4 	# Vector of 32-bit values.
	sub a0, a0, a4 		# Decrement count
	vmv.v.i v4, 1		# Splat immediate to destination
	vlw.v v4, (a3), v0.t 	# Load requested elements of C.
	sll t1, a4, 2 
	add a3, a3, t1 		# Bump pointer.
	vsw.v v4, (a2) 		# Store b[i].
	add a2, a2, t1		# Bump pointer.
	bnez a0, loop 		# Any more?
