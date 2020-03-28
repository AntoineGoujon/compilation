	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %r12, -16(%rbp)
	movq %rbx, -24(%rbp)
	movq $10, %rax
	movq $9, %rbx
	movq $8, %r10
	movq $7, %r12
	movq $6, %r9
	movq $5, %r8
	movq $4, %rcx
	movq $3, %rdx
	movq $2, %rsi
	movq $1, %rdi
	pushq %rax
	pushq %rbx
	pushq %r10
	pushq %r12
	call many
	addq $32, -8(%rbp)
	movq $0, %rax
	movq -16(%rbp), %r12
	movq -24(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
many:
	pushq %rbp
	movq %rsp, %rbp
	addq $-88, %rsp
	movq %r12, -80(%rbp)
	movq %rbx, -88(%rbp)
	movq %r9, -32(%rbp)
	movq %r8, -40(%rbp)
	movq %rcx, -48(%rbp)
	movq %rdx, -56(%rbp)
	movq %rsi, -64(%rbp)
	movq %rdi, %rbx
	movq 40(%rbp), %r12
	movq 32(%rbp), %r15
	movq %r15, -8(%rbp)
	movq 24(%rbp), %r15
	movq %r15, -16(%rbp)
	movq 16(%rbp), %r15
	movq %r15, -24(%rbp)
	movq $64, %rdi
	addq %rbx, %rdi
	call putchar
	movq -64(%rbp), %rax
	movq $64, %rdi
	addq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq -56(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq -48(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq -40(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq -32(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq -24(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq -16(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq -8(%rbp), %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq %r12, %rcx
	movq $64, %rdi
	addq %rcx, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	cmpq %rax, %rbx
	jl L26
L15:
	movq $0, %rbx
	movq %rbx, %rax
	movq -80(%rbp), %r12
	movq -88(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L26:
	movq %r12, %rax
	movq -8(%rbp), %r12
	movq -16(%rbp), %r10
	movq -24(%rbp), %r9
	movq -32(%rbp), %r8
	movq -40(%rbp), %rcx
	movq -48(%rbp), %rdx
	movq -56(%rbp), %rsi
	movq -64(%rbp), %rdi
	pushq %rbx
	pushq %rax
	pushq %r12
	pushq %r10
	call many
	movq %rax, %rbx
	addq $32, -72(%rbp)
	jmp L15
	.data
