#!/bin/bash

password_file="passwords.gpg"
decrypted_file="decrypted_passwords.txt"

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください (Add Password/Get Password/Exit):"
    read choice

    case $choice in
        "Add Password")
            echo "サービス名を入力してください:"
            read service_name
            echo "ユーザー名を入力してください:"
            read username
            echo "パスワードを入力してください:"
            read password
            echo "$service_name:$username:$password" >> $password_file
            echo "パスワードの追加は成功しました." 
            gpg --encrypt -r 5FE9C6FC84DAB7B2DE74F82EDB3C5A0382DB67F1 "$password_file"
            ;;
        "Get Password")
            echo "サービス名を入力してください:"
            read service_name
            gpg --decrypt $password_file > $decrypted_file
            if grep -q "^$service_name:" $decrypted_file; then
                password=$(grep "^$service_name:" $decrypted_file | cut -d ":" -f 3)
                echo "サービス名: $service_name"
                echo "ユーザー名: $(grep "^$service_name:" $decrypted_file | cut -d ":" -f 2)"
                echo "パスワード: $password"
                > $decrypted_file
            else
                echo "そのサービスは登録されていません。"
            fi
            ;;
        "Exit")
            echo "Thank you!"
            exit 0;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exit から入力してください.";;
    esac
done
