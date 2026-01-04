	.file	"main.c"
	.text
	.globl	convolve
	.def	convolve;	.scl	2;	.type	32;	.endef
	.seh_proc	convolve
convolve:
	.seh_endprologue
	cmpl	$4, %r8d
	jle	.L1
	addq	$16, %rcx
	leal	-2(%r8), %r10d
	movl	$2, %r9d
	leaq	f(%rip), %r8
.L3:
	movl	$0, %eax
	pxor	%xmm1, %xmm1
.L4:
	movsd	-16(%rcx,%rax), %xmm0
	mulsd	(%r8,%rax), %xmm0
	addsd	%xmm0, %xmm1
	addq	$8, %rax
	cmpq	$40, %rax
	jne	.L4
	movsd	%xmm1, (%rdx,%r9,8)
	addq	$1, %r9
	addq	$8, %rcx
	cmpq	%r10, %r9
	jne	.L3
.L1:
	ret
	.seh_endproc
	.globl	checksum
	.def	checksum;	.scl	2;	.type	32;	.endef
	.seh_proc	checksum
checksum:
	.seh_endprologue
	testl	%edx, %edx
	jle	.L9
	movq	%rcx, %rax
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,8), %rdx
	pxor	%xmm0, %xmm0
	.p2align 4
.L8:
	addsd	(%rax), %xmm0
	addq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L8
.L6:
	ret
.L9:
	pxor	%xmm0, %xmm0
	jmp	.L6
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Memory allocation failed\0"
.LC3:
	.ascii "Checksum: %f\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$40000000, %ecx
	call	malloc
	movq	%rax, %rbx
	movl	$40000000, %ecx
	call	malloc
	movq	%rax, %rsi
	testq	%rbx, %rbx
	je	.L16
	testq	%rax, %rax
	je	.L16
	movl	$0, %edx
	movsd	.LC2(%rip), %xmm1
	.p2align 6
.L12:
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	sarq	$37, %rax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$100, %eax, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%ecx, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rbx,%rdx,8)
	addq	$1, %rdx
	cmpq	$5000000, %rdx
	jne	.L12
	movl	$5000000, %r8d
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	convolve
	movl	$5000000, %edx
	movq	%rsi, %rcx
	call	checksum
	movq	%xmm0, %rdx
	movapd	%xmm0, %xmm1
	leaq	.LC3(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	free
	movq	%rsi, %rcx
	call	free
	movl	$0, %eax
.L11:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L16:
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	$-1, %eax
	jmp	.L11
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
	.align 8
.LC2:
	.long	0
	.long	1079574528
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
