	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-48, %rsp
	movq $10, %rdi
	movq $64, %rdi
	movq $65, %rdi
	movq $66, %rdi
	movq %rdi, -32(%rbp)
	movq $32, -32(%rbp)
	movq $32, -24(%rbp)
	movq $32, -16(%rbp)
	movq $32, -8(%rbp)
	movq $32, %r10
	movq $32, %rcx
	movq $32, %rdi
	movq $32, -40(%rbp)
	movq $32, %rdx
	movq $42, %rsi
	movq $10, %rax
	movq %rcx, %r9
	movq %rdi, %r8
	movq -40(%rbp), %rcx
	movq %rax, %rdi
	pushq -32(%rbp)
	pushq -24(%rbp)
	pushq -16(%rbp)
	pushq -8(%rbp)
	pushq %r10
	call many
	movq %rax, %rdi
	addq $40, -48(%rbp)
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
many:
	pushq %rbp
	movq %rsp, %rbp
	addq $-120, %rsp
	movq %r9, -104(%rbp)
	movq %r8, -96(%rbp)
	movq %rcx, -88(%rbp)
	movq %rdx, -80(%rbp)
	movq %rsi, -72(%rbp)
	movq %rdi, -56(%rbp)
	movq 48(%rbp), %r15
	movq %r15, -24(%rbp)
	movq 40(%rbp), %r15
	movq %r15, -16(%rbp)
	movq 32(%rbp), %r15
	movq %r15, -8(%rbp)
	movq 24(%rbp), %r15
	movq %r15, -120(%rbp)
	movq 16(%rbp), %r15
	movq %r15, -112(%rbp)
L67:
	movq -72(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -80(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -88(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -96(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -104(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -112(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -120(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -8(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -16(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -24(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq $10, %rdi
	call putchar
	movq %rax, %rdi
	movq $0, %rdi
	movq -56(%rbp), %r15
	movq %r15, -64(%rbp)
	cmpq %rdi, -64(%rbp)
	jle L42
	movq -72(%rbp), %r15
	movq %r15, -64(%rbp)
	movq -24(%rbp), %r15
	movq %r15, -48(%rbp)
	movq -16(%rbp), %r15
	movq %r15, -40(%rbp)
	movq -8(%rbp), %r15
	movq %r15, -32(%rbp)
	movq -120(%rbp), %r10
	movq -112(%rbp), %r8
	movq -104(%rbp), %rax
	movq -96(%rbp), %rcx
	movq -88(%rbp), %rdx
	movq -80(%rbp), %rsi
	movq $1, %r9
	movq -56(%rbp), %rdi
	subq %r9, %rdi
	movq %r8, %r9
	movq %rax, %r8
	movq -64(%rbp), %r15
	movq %r15, 48(%rbp)
	movq -48(%rbp), %r15
	movq %r15, 40(%rbp)
	movq -40(%rbp), %r15
	movq %r15, 32(%rbp)
	movq -32(%rbp), %r15
	movq %r15, 24(%rbp)
	movq %r10, 16(%rbp)
	jmp L67
L42:
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
