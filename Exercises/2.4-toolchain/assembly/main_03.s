	.file	"main.c"
	.text
	.p2align 4
	.globl	convolve
	.def	convolve;	.scl	2;	.type	32;	.endef
	.seh_proc	convolve
convolve:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	movups	%xmm6, (%rsp)
	.seh_savexmm	%xmm6, 0
	movups	%xmm7, 16(%rsp)
	.seh_savexmm	%xmm7, 16
	.seh_endprologue
	movq	%rcx, %r9
	movq	%rdx, %r10
	cmpl	$4, %r8d
	jle	.L1
	leaq	f(%rip), %r11
	leaq	16(%rdx), %rdx
	cmpl	$5, %r8d
	je	.L3
	leal	-2(%r8), %edx
	leaq	f(%rip), %r11
	movq	%rcx, %rax
	leaq	(%r10,%rdx,8), %rdx
	leaq	40(%r11), %rbx
	cmpq	%rdx, %r11
	leaq	16(%r10), %rdx
	setnb	%cl
	cmpq	%rbx, %rdx
	setnb	%bl
	orb	%bl, %cl
	je	.L3
	movq	%r10, %rcx
	subq	%r9, %rcx
	addq	$8, %rcx
	cmpq	$32, %rcx
	jbe	.L3
	leal	-4(%r8), %r11d
	shrl	%r8d
	movddup	f(%rip), %xmm7
	movddup	8+f(%rip), %xmm6
	leal	-2(%r8), %ecx
	movddup	16+f(%rip), %xmm5
	pxor	%xmm2, %xmm2
	movddup	24+f(%rip), %xmm4
	movq	%rcx, %r8
	movddup	32+f(%rip), %xmm3
	salq	$4, %rcx
	addq	%r9, %rcx
	.p2align 4
	.p2align 3
.L4:
	movupd	(%rax), %xmm0
	movupd	8(%rax), %xmm1
	addq	$16, %rax
	addq	$16, %rdx
	mulpd	%xmm7, %xmm0
	mulpd	%xmm6, %xmm1
	addpd	%xmm2, %xmm0
	addpd	%xmm1, %xmm0
	movupd	(%rax), %xmm1
	mulpd	%xmm5, %xmm1
	addpd	%xmm1, %xmm0
	movupd	8(%rax), %xmm1
	mulpd	%xmm4, %xmm1
	addpd	%xmm1, %xmm0
	movupd	16(%rax), %xmm1
	mulpd	%xmm3, %xmm1
	addpd	%xmm1, %xmm0
	movups	%xmm0, -16(%rdx)
	cmpq	%rcx, %rax
	jne	.L4
	addl	%r8d, %r8d
	cmpl	%r8d, %r11d
	je	.L1
	addl	$2, %r8d
	pxor	%xmm1, %xmm1
	movslq	%r8d, %rdx
	leaq	-2(%rdx), %rax
	movsd	(%r9,%rax,8), %xmm0
	mulsd	f(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	8(%r9,%rax,8), %xmm1
	mulsd	8+f(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	(%r9,%rdx,8), %xmm0
	mulsd	16+f(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	8(%r9,%rdx,8), %xmm1
	mulsd	24+f(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	16(%r9,%rdx,8), %xmm0
	mulsd	32+f(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%r10,%rdx,8)
.L1:
	movups	(%rsp), %xmm6
	movups	16(%rsp), %xmm7
	addq	$32, %rsp
	popq	%rbx
	ret
.L3:
	leal	-5(%r8), %ecx
	movq	%r9, %rax
	pxor	%xmm2, %xmm2
	leaq	8(%r9,%rcx,8), %rcx
	.p2align 4
	.p2align 3
.L6:
	movsd	(%r11), %xmm0
	mulsd	(%rax), %xmm0
	addq	$8, %rax
	addq	$8, %rdx
	movsd	8(%r11), %xmm1
	mulsd	(%rax), %xmm1
	addsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movsd	8(%rax), %xmm0
	mulsd	16(%r11), %xmm0
	addsd	%xmm1, %xmm0
	movsd	16(%rax), %xmm1
	mulsd	24(%r11), %xmm1
	addsd	%xmm0, %xmm1
	movsd	24(%rax), %xmm0
	mulsd	32(%r11), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rdx)
	cmpq	%rcx, %rax
	jne	.L6
	movups	(%rsp), %xmm6
	movups	16(%rsp), %xmm7
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4
	.globl	checksum
	.def	checksum;	.scl	2;	.type	32;	.endef
	.seh_proc	checksum
checksum:
	.seh_endprologue
	testl	%edx, %edx
	jle	.L26
	cmpl	$1, %edx
	je	.L27
	movl	%edx, %r8d
	movq	%rcx, %rax
	pxor	%xmm0, %xmm0
	shrl	%r8d
	salq	$4, %r8
	addq	%rcx, %r8
	.p2align 5
	.p2align 4
	.p2align 3
.L23:
	addsd	(%rax), %xmm0
	addq	$16, %rax
	addsd	-8(%rax), %xmm0
	cmpq	%rax, %r8
	jne	.L23
	movl	%edx, %eax
	andl	$-2, %eax
	andl	$1, %edx
	je	.L20
.L22:
	cltq
	addsd	(%rcx,%rax,8), %xmm0
.L20:
	ret
	.p2align 4,,10
	.p2align 3
.L26:
	pxor	%xmm0, %xmm0
	ret
.L27:
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	jmp	.L22
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "Memory allocation failed\0"
.LC7:
	.ascii "Checksum: %f\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$120, %rsp
	.seh_stackalloc	120
	movups	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	movups	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	movups	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	movups	%xmm9, 80(%rsp)
	.seh_savexmm	%xmm9, 80
	movups	%xmm10, 96(%rsp)
	.seh_savexmm	%xmm10, 96
	.seh_endprologue
	call	__main
	movl	$40000000, %ecx
	call	malloc
	movl	$40000000, %ecx
	movq	%rax, %rbx
	call	malloc
	movq	%rax, %rsi
	testq	%rbx, %rbx
	je	.L37
	testq	%rax, %rax
	je	.L37
	movl	$1374389535, %ecx
	movdqu	.LC1(%rip), %xmm2
	movq	%rbx, %rax
	movddup	.LC5(%rip), %xmm5
	movd	%ecx, %xmm3
	movl	$4, %ecx
	leaq	40000000(%rbx), %rdx
	pshufd	$0, %xmm3, %xmm3
	movdqa	%xmm3, %xmm4
	movd	%ecx, %xmm6
	psrad	$31, %xmm4
	pshufd	$0, %xmm6, %xmm6
	.p2align 4
	.p2align 3
.L33:
	movdqa	%xmm2, %xmm1
	movdqa	%xmm4, %xmm7
	movdqa	%xmm2, %xmm0
	addq	$32, %rax
	psrad	$31, %xmm1
	pmuludq	%xmm2, %xmm7
	movdqa	%xmm4, %xmm8
	pmuludq	%xmm3, %xmm1
	pmuludq	%xmm3, %xmm0
	paddq	%xmm7, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm1, %xmm0
	movdqa	%xmm2, %xmm1
	psrlq	$32, %xmm1
	movdqa	%xmm1, %xmm7
	pmuludq	%xmm1, %xmm8
	psrad	$31, %xmm7
	pmuludq	%xmm3, %xmm1
	pmuludq	%xmm3, %xmm7
	paddq	%xmm8, %xmm7
	psllq	$32, %xmm7
	paddq	%xmm7, %xmm1
	shufps	$221, %xmm1, %xmm0
	pshufd	$216, %xmm0, %xmm0
	psrad	$5, %xmm0
	movdqa	%xmm0, %xmm1
	pslld	$1, %xmm1
	paddd	%xmm0, %xmm1
	pslld	$3, %xmm1
	paddd	%xmm1, %xmm0
	movdqa	%xmm2, %xmm1
	paddd	%xmm6, %xmm2
	pslld	$2, %xmm0
	psubd	%xmm0, %xmm1
	cvtdq2pd	%xmm1, %xmm0
	divpd	%xmm5, %xmm0
	pshufd	$238, %xmm1, %xmm1
	cvtdq2pd	%xmm1, %xmm1
	divpd	%xmm5, %xmm1
	movups	%xmm0, -32(%rax)
	movups	%xmm1, -16(%rax)
	cmpq	%rax, %rdx
	jne	.L33
	movddup	f(%rip), %xmm8
	movddup	8+f(%rip), %xmm7
	leaq	32(%rbx), %rax
	movq	%rsi, %rcx
	movddup	16+f(%rip), %xmm6
	movupd	16(%rbx), %xmm0
	leaq	16(%rsi), %r8
	pxor	%xmm3, %xmm3
	movddup	24+f(%rip), %xmm5
	movddup	32+f(%rip), %xmm4
	movupd	(%rbx), %xmm1
	movupd	8(%rbx), %xmm10
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L36:
	movapd	%xmm1, %xmm0
	movapd	%xmm2, %xmm1
.L34:
	mulpd	%xmm8, %xmm1
	movupd	(%rax), %xmm2
	addq	$32, %rax
	addq	$32, %r8
	mulpd	%xmm7, %xmm10
	movupd	-40(%rax), %xmm9
	addpd	%xmm3, %xmm1
	addpd	%xmm10, %xmm1
	movapd	%xmm0, %xmm10
	mulpd	%xmm6, %xmm10
	mulpd	%xmm8, %xmm0
	addpd	%xmm10, %xmm1
	movapd	%xmm5, %xmm10
	mulpd	%xmm9, %xmm10
	addpd	%xmm3, %xmm0
	mulpd	%xmm7, %xmm9
	addpd	%xmm10, %xmm1
	movapd	%xmm2, %xmm10
	mulpd	%xmm4, %xmm10
	addpd	%xmm9, %xmm0
	movapd	%xmm6, %xmm9
	mulpd	%xmm2, %xmm9
	addpd	%xmm10, %xmm1
	movupd	-24(%rax), %xmm10
	addpd	%xmm9, %xmm0
	movapd	%xmm5, %xmm9
	mulpd	%xmm10, %xmm9
	movups	%xmm1, -32(%r8)
	movupd	-16(%rax), %xmm1
	addpd	%xmm9, %xmm0
	movapd	%xmm1, %xmm9
	mulpd	%xmm4, %xmm9
	addpd	%xmm9, %xmm0
	movups	%xmm0, -16(%r8)
	cmpq	%rax, %rdx
	jne	.L36
	leaq	40000000(%rsi), %rax
	pxor	%xmm1, %xmm1
	.p2align 5
	.p2align 4
	.p2align 3
.L35:
	addsd	(%rcx), %xmm1
	addq	$16, %rcx
	addsd	-8(%rcx), %xmm1
	cmpq	%rax, %rcx
	jne	.L35
	movq	%xmm1, %rdx
	leaq	.LC7(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	free
	movq	%rsi, %rcx
	call	free
	xorl	%eax, %eax
.L29:
	movups	32(%rsp), %xmm6
	movups	48(%rsp), %xmm7
	movups	64(%rsp), %xmm8
	movups	80(%rsp), %xmm9
	movups	96(%rsp), %xmm10
	addq	$120, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L37:
	leaq	.LC2(%rip), %rcx
	call	puts
	movl	$-1, %eax
	jmp	.L29
	.seh_endproc
	.globl	f
	.data
	.align 32
f:
	.long	-1717986918
	.long	1070176665
	.long	-1717986918
	.long	1069128089
	.long	-1717986918
	.long	1071225241
	.long	-1717986918
	.long	1069128089
	.long	-1717986918
	.long	1070176665
	.section .rdata,"dr"
	.align 16
.LC1:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 8
.LC5:
	.long	0
	.long	1079574528
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
