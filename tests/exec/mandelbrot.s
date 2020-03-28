	.text
	.globl main
add:
	pushq %rbp
	movq %rsp, %rbp
	addq %rsi, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
div:
	pushq %rbp
	movq %rsp, %rbp
	movq $8192, %rcx
	imulq %rcx, %rdi
	movq %rdi, %r8
	movq %rsi, %r8
	movq $2, %rcx
	movq %rsi, %rax
	cqto
	idivq %rcx
	movq %rax, %rsi
	movq %rdi, %rax
	addq %rsi, %rax
	cqto
	idivq %r8
	popq %rbp
	ret
sub:
	pushq %rbp
	movq %rsp, %rbp
	subq %rsi, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
of_int:
	pushq %rbp
	movq %rsp, %rbp
	movq $8192, %rcx
	imulq %rcx, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
mul:
	pushq %rbp
	movq %rsp, %rbp
	imulq %rsi, %rdi
	movq %rdi, %rcx
	movq $8192, %rcx
	movq $2, %rsi
	movq $8192, %rax
	cqto
	idivq %rsi
	addq %rax, %rdi
	movq %rdi, %rax
	cqto
	idivq %rcx
	movq %rax, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
iter:
	pushq %rbp
	movq %rsp, %rbp
	addq $-72, %rsp
	movq %r12, -72(%rbp)
	movq %r8, %r12
	movq %rcx, -16(%rbp)
	movq %rdx, -56(%rbp)
	movq %rsi, -32(%rbp)
	movq %rdi, -64(%rbp)
	movq $100, %rcx
	movq -64(%rbp), %rdi
	cmpq %rcx, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L76
	movq $1, %rax
L39:
	movq -72(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
L76:
	movq -16(%rbp), %rdi
	movq %rdi, %rsi
	movq -16(%rbp), %rdi
	call mul
	movq %rax, -40(%rbp)
	movq -40(%rbp), %rdi
	movq %r12, %rdi
	movq %rdi, %rsi
	movq %r12, %rdi
	call mul
	movq %rax, -48(%rbp)
	movq -48(%rbp), %rdi
	movq $4, %rdi
	call of_int
	movq %rax, -24(%rbp)
	movq -48(%rbp), %rsi
	movq -40(%rbp), %rdi
	call add
	cmpq -24(%rbp), %rax
	setg %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L58
	movq $0, %rax
	jmp L39
L58:
	movq %r12, %rsi
	movq -16(%rbp), %rdi
	call mul
	movq %rax, %r12
	movq $2, %rdi
	call of_int
	movq %r12, %rsi
	movq %rax, %rdi
	call mul
	movq -56(%rbp), %rsi
	movq %rax, %rdi
	call add
	movq %rax, %r12
	movq -32(%rbp), %r15
	movq %r15, -8(%rbp)
	movq -48(%rbp), %rcx
	movq -40(%rbp), %rdi
	movq %rcx, %rsi
	call sub
	movq -8(%rbp), %rsi
	movq %rax, %rdi
	call add
	movq %rax, %rcx
	movq -56(%rbp), %rdx
	movq -32(%rbp), %rsi
	movq $1, %rax
	movq -64(%rbp), %rdi
	addq %rax, %rdi
	movq %r12, %r8
	call iter
	jmp L39
run:
	pushq %rbp
	movq %rsp, %rbp
	addq $-88, %rsp
	movq %r12, -88(%rbp)
	movq %rdi, -80(%rbp)
	movq $2, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	call of_int
	movq %rax, -72(%rbp)
	movq -72(%rbp), %rdi
	movq $1, %rdi
	call of_int
	movq %rax, -24(%rbp)
	movq -24(%rbp), %rcx
	movq -80(%rbp), %rcx
	movq $2, %rdi
	imulq %rcx, %rdi
	call of_int
	movq %rax, %r12
	movq -72(%rbp), %rsi
	movq -24(%rbp), %rdi
	call sub
	movq %rax, %rdi
	movq %r12, %rsi
	call div
	movq %rax, -64(%rbp)
	movq -64(%rbp), %rcx
	movq $1, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	call of_int
	movq %rax, -56(%rbp)
	movq -56(%rbp), %rdi
	movq $1, %rdi
	call of_int
	movq %rax, %r12
	movq %r12, %rdi
	movq -80(%rbp), %rdi
	call of_int
	movq %rax, -8(%rbp)
	movq %r12, %rdi
	movq -56(%rbp), %rsi
	call sub
	movq -8(%rbp), %rsi
	movq %rax, %rdi
	call div
	movq %rax, -40(%rbp)
	movq -40(%rbp), %rdi
	movq $0, %rdi
	movq %rdi, -48(%rbp)
	movq -48(%rbp), %rdi
L132:
	movq -80(%rbp), %rdi
	movq -48(%rbp), %r12
	cmpq %rdi, %r12
	jl L129
	movq $0, -48(%rbp)
	movq -48(%rbp), %rax
	movq -88(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
L129:
	movq -40(%rbp), %r12
	movq -48(%rbp), %rdi
	call of_int
	movq %r12, %rsi
	movq %rax, %rdi
	call mul
	movq %rax, %rcx
	movq -56(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, -16(%rbp)
	movq -16(%rbp), %r15
	movq %r15, -32(%rbp)
	movq $0, -32(%rbp)
	movq -32(%rbp), %rcx
L118:
	movq -80(%rbp), %rcx
	movq $2, %rdi
	imulq %rcx, %rdi
	movq -32(%rbp), %r12
	cmpq %rdi, %r12
	jl L113
	movq $10, %rdi
	call putchar
	movq $1, %rax
	movq -48(%rbp), %rdi
	addq %rax, %rdi
	movq %rdi, -48(%rbp)
	jmp L132
L113:
	movq -64(%rbp), %r12
	movq -32(%rbp), %rdi
	call of_int
	movq %rax, %rdi
	movq %r12, %rsi
	call mul
	movq %rax, %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	movq %rdi, %rcx
	movq -16(%rbp), %rcx
	movq %rcx, %rsi
	call inside
	cmpq $0, %rax
	jz L101
	movq $48, %rax
	movq %rax, %rdi
	call putchar
L97:
	movq $1, %rax
	movq -32(%rbp), %rdi
	addq %rax, %rdi
	movq %rdi, -32(%rbp)
	movq -32(%rbp), %rdi
	jmp L118
L101:
	movq $49, %rdi
	call putchar
	jmp L97
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $30, %rdi
	call run
	movq %rax, %rdi
	movq $0, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
inside:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %r12, -16(%rbp)
	movq %rbx, -24(%rbp)
	movq %rsi, %r12
	movq %rdi, %rbx
	movq $0, %rdi
	call of_int
	movq %rax, -8(%rbp)
	movq $0, %rdi
	call of_int
	movq %rax, %rcx
	movq %r12, %rdx
	movq $0, %rdi
	movq -8(%rbp), %r8
	movq %rbx, %rsi
	call iter
	movq %rax, %rdi
	movq %rdi, %rax
	movq -16(%rbp), %r12
	movq -24(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
