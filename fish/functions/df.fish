function df --description 'alias df=df -hx squashfs -x tmpfs -x devtempfs -x efivarfs'
 command df -hx squashfs -x tmpfs -x devtempfs -x efivarfs $argv
        
end
