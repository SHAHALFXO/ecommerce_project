package db

import (
	"fmt"
	"os"

	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)
 var DB *gorm.DB
func Connection(){
	err:=godotenv.Load()
	if err!=nil{
		panic("error loading env")
	}

	host:=os.Getenv("DB_HOST")
	user:=os.Getenv("DB_USER")
	password:=os.Getenv("DB_PASSWORD")
	dbname:=os.Getenv("DB_NAME")
	port:=os.Getenv("DB_PORT")
	sslmode:=os.Getenv("DB_SSLMODE")

	dsn:=fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s",host,user,password,dbname,port,sslmode)

   database,err:=gorm.Open(postgres.Open(dsn),&gorm.Config{})
   if err!=nil{
	panic("database connection failed")
   }

   fmt.Println("database connection succesful")
   DB=database

}