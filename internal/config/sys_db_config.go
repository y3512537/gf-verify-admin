package config

import (
	"context"
	"database/sql"
	"github.com/gogf/gf/contrib/drivers/mysql/v2"
	"github.com/gogf/gf/v2/database/gdb"
)

type MyDriver struct {
	*mysql.DriverMysql
}

var (
	driverName = "mysql"
)

func init() {
	if err := gdb.Register(driverName, &MyDriver{}); err != nil {
		panic(err)
	}
}

func (d *MyDriver) New(core *gdb.Core, node *gdb.ConfigNode) (gdb.DB, error) {
	return &MyDriver{
		&mysql.DriverMysql{
			Core: core,
		},
	}, nil
}
func (d *MyDriver) DoQuery(ctx context.Context, link gdb.Link, sql string, args ...interface{}) (rows gdb.Result, err error) {
	rows, err = d.DriverMysql.DoQuery(ctx, link, sql, args...)
	return
}
func (d *MyDriver) DoExec(ctx context.Context, link gdb.Link, sql string, args ...interface{}) (result sql.Result, err error) {
	result, err = d.DriverMysql.DoExec(ctx, link, sql, args...)
	return
}
