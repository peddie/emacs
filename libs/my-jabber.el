;;;;;; jabber chat client ;;;;;;;

(setq jabber-chat-header-line-format (quote ("" (:eval (jabber-jid-displayname jabber-chatting-with)) "	" (:eval (let ((buddy (jabber-jid-symbol jabber-chatting-with))) (propertize (or (cdr (assoc (get buddy (quote show)) jabber-presence-strings)) (get buddy (quote show))) (quote face) (or (cdr (assoc (get buddy (quote show)) jabber-presence-faces)) (quote jabber-roster-user-online))))) "	" (:eval (jabber-fix-status (get (jabber-jid-symbol jabber-chatting-with) (quote status)))) "	" jabber-events-message)))

(setq jabber-connection-type 'ssl)
(setq jabber-network-server "talk.google.com")
(setq jabber-nickname "Matt Peddie")
(setq jabber-roster-line-format "%c %-25n %u %-8s  %-30S
")
(setq jabber-server "gmail.com")
(setq jabber-username "mpeddie")