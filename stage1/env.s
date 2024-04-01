	.file	"env.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	env_store
	.type	env_store, @function
env_store:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-56(s0)
	sd	a2,-48(s0)
	sd	a3,-64(s0)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	ld	a3,-64(s0)
	ld	a1,-56(s0)
	ld	a2,-48(s0)
	mv	a0,a5
	call	hash_table_upsert_string
	sd	a0,-24(s0)
	ld	a5,-40(s0)
	ld	a5,16(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	release_pyobject
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	env_store, .-env_store
	.align	1
	.globl	env_load
	.type	env_load, @function
env_load:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-56(s0)
	sd	a2,-48(s0)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	ld	a1,-56(s0)
	ld	a2,-48(s0)
	mv	a0,a5
	call	hash_table_get_string
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L3
	ld	a5,-40(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L4
	li	a5,0
	j	.L5
.L4:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	ld	a2,-48(s0)
	mv	a0,a5
	call	env_load
	mv	a5,a0
	j	.L5
.L3:
	ld	a5,-40(s0)
	ld	a5,16(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	copy_pyobject
	mv	a5,a0
.L5:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	env_load, .-env_load
	.ident	"GCC: () 13.2.0"
