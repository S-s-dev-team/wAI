package config

import (
	"context"
	"fmt"
	"strings"

	"github.com/sethvargo/go-envconfig"
)

type ServiceEnv string

const (
	ServiceEnvLocal      = "local"
	ServiceEnvTest       = "test"
	ServiceEnvStaging    = "staging"
	ServiceEnvProduction = "production"
)

func (se ServiceEnv) IsLocal() bool {
	return se == ServiceEnvLocal
}

func (se ServiceEnv) IsTest() bool {
	return se == ServiceEnvTest
}

func (se ServiceEnv) IsStaging() bool {
	return se == ServiceEnvStaging
}

func (se ServiceEnv) IsProduction() bool {
	return se == ServiceEnvProduction
}

func (se ServiceEnv) String() string {
	return string(se)
}

type Database struct {
	User                   string `env:"DATABASE_USER,default=postgres"`
	Password               string `env:"DATABASE_PASSWORD,required"`
	InstanceConnectionName string `env:"INSTANCE_CONNECTION_NAME"`
	Name                   string `env:"DATABASE_NAME,default=onbo"`
	SocketDir              string `env:"DATABASE_SOCKET_DIR,default=/cloudsql"`
	Host                   string `env:"DATABASE_HOST,default=localhost"`
	Port                   int    `env:"DATABASE_PORT,default=5432"`
}

func (d *Database) DataSourceName() string {
	if d.InstanceConnectionName == "" {
		return fmt.Sprintf(
			"user=%s password=%s database=%s host=%s port=%d sslmode=disable",
			d.User, d.Password, d.Name, d.Host, d.Port,
		)
	}
	return fmt.Sprintf(
		"user=%s password=%s database=%s host=%s/%s",
		d.User, d.Password, d.Name, d.SocketDir, d.InstanceConnectionName,
	)
}

type Vars struct {
	Database              *Database
	Port                  int    `env:"PORT,default=8010"`
	FirebaseAuthProjectID string `env:"FIREBASE_AUTH_PROJECT_ID,required"`
	GeminiAPIKey          string `env:"GEMINI_API_KEY,required"`
	AllowedEmailDomains   string `env:"ALLOWED_EMAIL_DOMAINS"`
	ChatHistoryLimit      int    `env:"CHAT_HISTORY_LIMIT,default=10"`
}

func (v *Vars) ParseAllowedEmailDomains() []string {
	if v.AllowedEmailDomains == "" {
		return nil
	}
	var domains []string
	for _, d := range strings.Split(v.AllowedEmailDomains, ",") {
		d = strings.TrimSpace(d)
		if d != "" {
			domains = append(domains, d)
		}
	}
	return domains
}

func New(ctx context.Context) (*Vars, error) {
	var vars Vars
	if err := envconfig.Process(ctx, &vars); err != nil {
		return nil, err
	}
	return &vars, nil
}

func MustNew(ctx context.Context) *Vars {
	vars, err := New(ctx)
	if err != nil {
		panic(err)
	}
	return vars
}