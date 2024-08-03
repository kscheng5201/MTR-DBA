#/bin/sh 
Device=$1
DISK=$2

case $DISK in
        rrqm_s)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $2}' #每秒讀請求被合併次數
                ;;
        wrqm_s)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $3}' #每秒寫請求被合併次數
                ;;
        r_s)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $4}' #每秒完成的讀次數
                ;;
        w_s)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $5}' #每秒完成的寫次數
                ;;
        rkb_s)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $6}' #每秒讀數據量(kb)
                ;;
        wkb_s)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $7}' #每秒寫數據量(kb) 
                ;;
        avgrq_sz)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $8}' #平均每次IO請求的扇區大小
                ;;
        avgqu_sz)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $9}' #平均每次IO請求的隊列長度(越短越好)
                ;;
        await)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $10}' #平均每次IO請求等待時間(毫秒) 
                ;;
        r_await)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $11}' #讀的平均耗時(毫秒)
                ;;
        w_await)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $12}' #寫入平均耗時(毫秒)
                ;;
        svctm)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $13}' #平均每次IO請求處理時間(毫秒)
                ;;
        util)
                iostat -dxkt 1 2 | grep "\b$Device\b" | awk 'NR==2{print $14}' #IO隊列非空比例
                ;;
esac

