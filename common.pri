CONFIG(debug, debug|release) {
  BUILD_TYPE = debug
} else {
  BUILD_TYPE = release
}

# Make sure that the BUILD_ROOT environment variable is set. Without it we don't know where to build.
isEmpty(ETC2_BUILD_ROOT) : ETC2_BUILD_ROOT = $$(ETC2_BUILD_ROOT)
isEmpty(ETC2_BUILD_ROOT) {
  greaterThan(QT_MAJOR_VERSION, 4) {
    # Qt 5 introduced a special 'shadowed' replace function that gives us access to the build directory.
    ETC2_BUILD_ROOT = $$shadowed(.)
  }
  else {
    ETC2_BUILD_ROOT = $$PWD/objects/$$BUILD_TYPE
  }
}

isEmpty(ETC2_LIBRARY_DESTINATION) : ETC2_LIBRARY_DESTINATION = $$(ETC2_LIBRARY_DESTINATION)
isEmpty(ETC2_LIBRARY_DESTINATION) {
  dest = $$ETC2_BUILD_ROOT/lib
  ETC2_LIBRARY_DESTINATION = $$replace(dest, /, $$QMAKE_DIR_SEP)
}

LIBS += -L$$ETC2_LIBRARY_DESTINATION
