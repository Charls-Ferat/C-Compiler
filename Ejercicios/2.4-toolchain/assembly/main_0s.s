	.file	"main.c"
	.text
	.globl	convolve
	.def	convolve;	.scl	2;	.type	32;	.endef
	.seh_proc	convolve
convolve:
	.seh_endprologue
	movl	$2, %eax
	leaq	f(%rip), %r10
	subl	$2, %r8d
.L2:
	cmpl	%eax, %r8d
	jle	.L7
	leaq	(%rcx,%rax,8), %r11
	xorl	%r9d, %r9d
	xorps	%xmm0, %xmm0
.L3:
	movsd	-16(%r11,%r9), %xmm1
	mulsd	(%r10,%r9), %xmm1
	addq	$8, %r9
	addsd	%xmm1, %xmm0
	cmpq	$40, %r9
	jne	.L3
	movsd	%xmm0, (%rdx,%rax,8)
	incq	%rax
	jmp	.L2
.L7:
	ret
	.seh_endproc
	.globl	checksum
	.def	checksum;	.scl	2;	.type	32;	.endef
	.seh_proc	checksum
checksum:
	.seh_endprologue
	xorl	%eax, %eax
	xorps	%xmm0, %xmm0
.L9:
	cmpl	%eax, %edx
	jle	.L11
	addsd	(%rcx,%rax,8), %xmm0
	incq	%rax
	jmp	.L9
.L11:
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Memory allocation failed\0"
.LC3:
	.ascii "Checksum: %f\12\0"
	.section	.text.startup,"x"
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
	movl	$40000000, %ecx
	movq	%rax, %rsi
	call	malloc
	movq	%rax, %rbx
	testq	%rsi, %rsi
	je	.L17
	xorl	%ecx, %ecx
	testq	%rax, %rax
	je	.L17
	movsd	.LC2(%rip), %xmm1
	movl	$100, %r8d
	jmp	.L13
.L17:
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	$-1, %eax
	jmp	.L12
.L13:
	movl	%ecx, %eax
	cltd
	idivl	%r8d
	cvtsi2sdl	%edx, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rsi,%rcx,8)
	incq	%rcx
	cmpq	$5000000, %rcx
	jne	.L13
	movl	$5000000, %r8d
	movq	%rbx, %rdx
	movq	%rsi, %rcx
	call	convolve
	movl	$5000000, %edx
	movq	%rbx, %rcx
	call	checksum
	leaq	.LC3(%rip), %rcx
	movq	%xmm0, %rdx
	movaps	%xmm0, %xmm1
	call	printf
	movq	%rsi, %rcx
	call	free
	movq	%rbx, %rcx
	call	free
	xorl	%eax, %eax
.L12:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
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
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
