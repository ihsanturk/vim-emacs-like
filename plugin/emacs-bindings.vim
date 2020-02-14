" Basic cursor movement and deletion keybindings from emacs, for vim.

" insert-mode
im <C-b> <Left>
im <C-f> <Right>
im <C-a> <C-o>:call <SID>home()<CR>
im <C-e> <End>
im <C-d> <Del>
im <C-h> <BS>
im <C-k> <C-r>=<SID>kill_line()<CR>
im <M-d> <C-o>de
im <M-b> <S-Left>
im <M-f> <S-Right>
im <M-backspace> <C-w>

" ex-mode
cm <C-p> <Up>
cm <C-n> <Down>
cm <C-b> <Left>
cm <C-f> <Right>
cm <C-a> <Home>
cm <C-e> <End>
cm <M-b> <S-Left>
cm <M-f> <S-Right>
cm <M-backspace> <C-w>
cno <C-d> <Del>
cno <C-h> <BS>
cno <C-k> <C-f>D<C-c><C-c>:<Up>

"=== Functions ================================================================
function! s:home()
	let start_col = col('.')
	normal! ^
	if col('.') == start_col
		normal! 0
	endif
	return ''
endfunction

function! s:kill_line()
	let [text_before_cursor, text_after_cursor] = s:split_line_text_at_cursor()
	if len(text_after_cursor) == 0
		normal! J
	else
		call setline(line('.'), text_before_cursor)
	endif
	return ''
endfunction

function! s:split_line_text_at_cursor()
	let line_text = getline(line('.'))
	let text_after_cursor	= line_text[col('.')-1 :]
	let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
	return [text_before_cursor, text_after_cursor]
endfunction
