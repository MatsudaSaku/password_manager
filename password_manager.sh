#!/bin/bash

password_file="passwords.txt"

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
            echo "パスワードの追加は成功しました。";;
        "Get Password")
            echo "サービス名を入力してください:"
            read service_name
            if grep -q "^$service_name:" $password_file; then
                password=$(grep "^$service_name:" $password_file | cut -d ":" -f 3)
                echo "サービス名: $service_name"
                echo "ユーザー名: $(grep "^$service_name:" $password_file | cut -d ":" -f 2)"
                echo "パスワード: $password"
            else
                echo "そのサービスは登録されていません。"
            fi;;
        "Exit")
            echo "Thank you!"
            exit 0;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exit から入力してください.";;
    esac
done