package main

import (
    "bufio"
    "errors"
    "fmt"
    "os"
    "path/filepath"
    "regexp"
    "runtime"
    "strings"
)

const (
    CONF_DEF = "targets"
    FILE_DELIMITER = ":"
    SRC_DIR_ENV_VAR = "HOME"
)

func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Fprintln(os.Stderr, r)
        }
    }()

    exeDir, err := ExeDir()
    if err != nil {
        panic(err)
    }
    os.Chdir(exeDir)
    srcDir, err := SrcDir()
    if err != nil {
        panic(err)
    }
    dstDir, err := DstDir()
    if err != nil {
        panic(err)
    }

    targets_file, err := TargetsFile()
    if err != nil {
        panic(err)
    }
    fmt.Printf("config file: %s\n", targets_file)

    fp, err := os.Open(targets_file)
    if err != nil {
        panic(err)
    }
    defer fp.Close()

    s := bufio.NewScanner(fp)
    var src, dst string
    d := regexp.MustCompile(FILE_DELIMITER)

    for s.Scan() {
        if err := s.Err(); err != nil {
            panic(err)
        }

        file := d.Split(s.Text(), 3)
        switch len(file) {
        case 1:
            src = filepath.Join(srcDir, file[0])
            dst = filepath.Join(dstDir, file[0])
        case 2:
            src = filepath.Join(srcDir, file[0])
            dst = filepath.Join(dstDir, file[1])
        }

        if !exists(src) {
            fmt.Printf("The source doesn't exist: %s\n", src)
            continue
        }
        if exists(dst) {
            fmt.Printf("The distination already exists: %s\n", dst)
            continue
        }

        fmt.Printf("Creating symlink %s => %s\n", src, dst)
        os.Symlink(src, dst)
    }
}

func SrcDir() (string, error) {
    exeDir, err := ExeDir()
    if err != nil {
        return "", err
    }

    dir, err := filepath.Abs(filepath.Join(exeDir, "..", ".."))
    if err != nil {
        return "", err
    }
    return dir, nil
}

func DstDir() (dir string, err error) {
    envVars := envVars()
    if _, ok := envVars[SRC_DIR_ENV_VAR]; !ok {
        return "", errors.New("Define the environment variable \"HOME\"")
    }
    return envVars[SRC_DIR_ENV_VAR], nil
}

func TargetsFile() (file string, err error) {
    ext := "." + runtime.GOOS

    targets_file := CONF_DEF + ext
    if exists(targets_file) {
        return targets_file, nil
    }
    if !exists(CONF_DEF) {
        return "", errors.New("Create \"targets\" file")
    }

    return CONF_DEF, nil
}

func ExeDir() (string, error) {
    dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
    if err != nil {
        return "", err
    }
    return dir, nil
}

func exists(path string) bool {
    _, err := os.Stat(path);
    return !os.IsNotExist(err)
}

func envVars() map[string]string {
    items := make(map[string]string)
    for _, item := range os.Environ() {
        splits := strings.Split(item, "=")
        items[splits[0]] = splits[1]
    }
    return items
}
